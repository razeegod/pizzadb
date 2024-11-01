from sqlalchemy import create_engine, func, and_, between
from sqlalchemy.orm import sessionmaker, aliased, joinedload
import logging
import datetime

from db_classes import *


engine = create_engine('postgresql+psycopg2://postgres:1234@localhost:5432/PizzaDB')

Session = sessionmaker(bind=engine)
session = Session()


def revenue_pizzas_period(start_date, end_date):
    """
    Вычисляет и возвращает суммарную выручку за продажу напитков за определенный период.
    :param start_date: начало периода (Дата)
    :param end_date: конец периода (Дата)
    :return: сумма выручку (Инт)
    """

    revenue_pizza = session.query(func.sum(Size.price)). \
        join(Pizza, Size.name == Pizza.size). \
        join(CustomerPizza, Pizza.id == CustomerPizza.pizza_id). \
        join(CustomerOrder, CustomerPizza.customer_order_id == CustomerOrder.id). \
        filter(CustomerOrder.order_date.between(start_date, end_date)).scalar()
    return revenue_pizza


def revenue_drinks_period(start_date, end_date):
    """
    Вычисляет и возвращает суммарную выручку за продажу пицц за определенный период.
    :param start_date: начало периода (Дата)
    :param end_date: конец периода (Дата)
    :return: сумма выручку (Инт)
    """

    revenue_drink = session.query(func.sum(Drink.price)). \
        join(CustomerDrink, Drink.name == CustomerDrink.drink). \
        join(CustomerOrder, CustomerDrink.customer_order_id == CustomerOrder.id). \
        filter(CustomerOrder.order_date.between(start_date, end_date)).scalar()
    return revenue_drink


if __name__ == '__main__':
    start_date = datetime.date(2024, 9, 1)
    end_date = datetime.date(2024, 9, 30)

    revenue_p = revenue_pizzas_period(start_date, end_date)
    print(f'Выручка за продажу пицц в период с {start_date} по {end_date} составляет {revenue_p} руб.')

    revenue_d = revenue_drinks_period(start_date, end_date)
    print(f'Выручка за продажу напитков в период с {start_date} по {end_date} составляет {revenue_d} руб.')

    logging.basicConfig()
    logging.getLogger('sqlalchemy.engine').setLevel(logging.INFO)