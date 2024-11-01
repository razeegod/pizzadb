from sqlalchemy import Column, String, BigInteger, Integer, Date, DECIMAL, ForeignKey
from sqlalchemy.orm import declarative_base, relationship

base = declarative_base()


class Customer(base):
    __tablename__ = 'customer'

    id = Column(Integer, primary_key=True)
    name = Column(String)
    address = Column(String)
    phone = Column(String)


class Drink(base):
    __tablename__ = 'drinks'

    name = Column(String, primary_key=True)
    price = Column(DECIMAL(8, 2))


class Size(base):
    __tablename__ = 'sizes'

    name = Column(String, primary_key=True)
    price = Column(DECIMAL(8, 2))


class Topping(base):
    __tablename__ = 'toppings'

    name = Column(String, primary_key=True)


class CreditCard(base):
    __tablename__ = 'credit_card'

    id = Column(Integer, primary_key=True)
    name = Column(String)
    number = Column(BigInteger)
    expiration = Column(Date)


class CustomerCreditCard(base):
    __tablename__ = 'customer_credit_card'

    customer_id = Column(Integer, ForeignKey('customer.id'), primary_key=True)
    credit_card_id = Column(Integer, ForeignKey('credit_card.id'), primary_key=True)


class CustomerOrder(base):
    __tablename__ = 'customer_order'

    id = Column(Integer, primary_key=True)
    customer_id = Column(Integer, ForeignKey('customer.id'))
    credit_card_id = Column(Integer, ForeignKey('credit_card.id'))
    total_price = Column(DECIMAL(8, 2))
    order_date = Column(Date)

    customer = relationship('Customer', back_populates='customer_order')

Customer.customer_order = relationship('CustomerOrder', order_by=Customer.id, back_populates='customer')


class CustomerOrderPreference(base):
    __tablename__ = 'customer_order_preference'

    customer_id = Column(Integer, ForeignKey('customer.id'), primary_key=True)
    customer_order_id = Column(Integer, ForeignKey('customer_order.id'), primary_key=True)


class CustomerDrink(base):
    __tablename__ = 'customer_drinks'

    customer_order_id = Column(Integer, ForeignKey('customer_order.id'), primary_key=True)
    drink = Column(String, ForeignKey('drinks.name'), primary_key=True)


class Pizza(base):
    __tablename__ = 'pizzas'

    id = Column(Integer, primary_key=True)
    size = Column(String, ForeignKey('sizes.name'))
    topping_1 = Column(String, ForeignKey('toppings.name'))
    topping_2 = Column(String, ForeignKey('toppings.name'))


class CustomerPizza(base):
    __tablename__ = 'customer_pizzas'

    customer_order_id = Column(Integer, ForeignKey('customer_order.id'), primary_key=True)
    pizza_id = Column(Integer, ForeignKey('pizzas.id'), primary_key=True)
