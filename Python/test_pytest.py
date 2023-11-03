import pytest
from calculator import calculator

@pytest.fixture
def calculator():
    return calculator()

def test_adder(calculator):
    result = calculator.add(3,4)
    assert result == 7
