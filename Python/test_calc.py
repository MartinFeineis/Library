import unittest
from calculator import calculator

class CalculatorTest(unittest.TestCase):

    def test_addition(self):
        calc = calculator()
        result = calc.addition(4,5)
        self.assertEqual(result,9)
