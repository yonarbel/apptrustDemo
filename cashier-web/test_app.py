import pytest
from app import MENU, bill


def test_menu_has_prices():
    """Test that menu items have valid prices"""
    assert "burger" in MENU
    assert MENU["burger"] > 0
    assert "fries" in MENU
    assert "drink" in MENU


def test_bill_calc():
    """Test bill calculation for multiple items"""
    class FakeOrder:
        items = ["burger", "drink"]

    res = bill(FakeOrder())
    assert res["total"] == MENU["burger"] + MENU["drink"]
    assert len(res["line_items"]) == 2


def test_bill_with_unknown_item():
    """Test that unknown items are charged as $0"""
    class FakeOrder:
        items = ["burger", "unknown_item"]

    res = bill(FakeOrder())
    assert res["total"] == MENU["burger"]
    assert res["line_items"][1]["price"] == 0
