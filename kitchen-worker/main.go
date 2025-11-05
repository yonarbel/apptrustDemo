package main

import (
	"encoding/json"
	"fmt"
	"os"
	"time"
)

// pretend this is our order queue
// in reality you might poll Redis, SQS, Kafka...
type Order struct {
	ID      int      `json:"id"`
	Items   []string `json:"items"`
	TableNo int      `json:"tableNo"`
}

var queue = []Order{
	{ID: 101, Items: []string{"burger", "fries"}, TableNo: 12},
	{ID: 102, Items: []string{"burger", "drink"}, TableNo: 4},
}

func popOrder() (Order, bool) {
	if len(queue) == 0 {
		return Order{}, false
	}
	o := queue[0]
	queue = queue[1:]
	return o, true
}

// process simulates the kitchen actually making the food
func process(o Order) {
	fmt.Printf("[kitchen-worker] Preparing order %d for table %d: %v\n", o.ID, o.TableNo, o.Items)
	time.Sleep(100 * time.Millisecond) // pretend cooking
	fmt.Printf("[kitchen-worker] DONE order %d\n", o.ID)
}

func main() {
	if len(os.Args) > 1 && os.Args[1] == "peek" {
		bytes, _ := json.MarshalIndent(queue, "", "  ")
		fmt.Println(string(bytes))
		return
	}

	// default behavior: take next order and process it
	o, ok := popOrder()
	if !ok {
		fmt.Println("[kitchen-worker] No pending orders")
		return
	}
	process(o)
}
