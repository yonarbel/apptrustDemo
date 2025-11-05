package main

import "testing"

func TestPopOrderRemovesFromQueue(t *testing.T) {
	// local copy of queue so we don't mutate global in tests
	localQueue := []Order{
		{ID: 1, Items: []string{"burger"}, TableNo: 5},
	}
	queue = localQueue

	o, ok := popOrder()
	if !ok {
		t.Fatalf("expected order, got none")
	}
	if o.ID != 1 {
		t.Fatalf("expected ID=1, got %d", o.ID)
	}
	if len(queue) != 0 {
		t.Fatalf("expected queue empty after pop")
	}
}
