from sqlalchemy import create_engine, text, MetaData
import datetime
import logging


engine = create_engine('postgresql+psycopg2://postgres:1234@localhost:5432/PizzaDB')


def get_revenue_pizzas_period(start_date, end_date):
    with engine.begin() as conn:
        sql = text(
            '''SELECT 
                    SUM(s.price) AS Сумма
                FROM
                    customer_order co 
                    INNER JOIN customer_pizzas cp ON co.id = cp.customer_order_id 
                    INNER JOIN pizzas p ON cp.pizza_id = p.id 
                    INNER JOIN sizes s ON p."size" = s."name" 
                WHERE
                    co.order_date BETWEEN :start_date AND :end_date;'''
        )
        result = conn.execute(sql, {'start_date' : start_date, 'end_date': end_date}).scalar()
        return result


def get_revenue_drinks_period(start_date, end_date):
    with engine.begin() as conn:
        sql = text(
            '''SELECT 
                    SUM(d.price) AS Сумма
                FROM
                    customer_order co 
                    INNER JOIN customer_drinks cd ON co.id = cd.customer_order_id 
                    INNER JOIN drinks d ON cd.drink = d."name" 
                WHERE
                    co.order_date BETWEEN :start_date AND :end_date;'''
        )
        result = conn.execute(sql, {'start_date' : start_date, 'end_date': end_date}).scalar()
        return result


if __name__ == '__main__':
    start_date = datetime.date(2024, 9, 1)
    end_date = datetime.date(2024, 9, 30)

    revenue_p = get_revenue_pizzas_period(start_date, end_date)
    print(f'Выручка за продажу пицц в период с {start_date} по {end_date} составляет {revenue_p} руб.')

    revenue_d = get_revenue_drinks_period(start_date, end_date)
    print(f'Выручка за продажу напитков в период с {start_date} по {end_date} составляет {revenue_d} руб.')

    logging.basicConfig()
    logging.getLogger('sqlalchemy.engine').setLevel(logging.INFO)