# mini-components
A bunch of mini components:
- d_latch & and_or_latch
- stack (hardware implementation)
- queue (hardware implementation)

# testing:
iverilog -o tests/latch_tb src/latch.v testbench/latch_tb.v

iverilog -o tests/stack_test src/stack.v testbench/stack_tb.v

iverilog -o tests/queue_test src/queue.v testbench/queue_tb.v