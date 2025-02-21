module queue_tb;
    reg clk;
    reg rst;
    reg enqueue;
    reg dequeue;
    reg peek;
    reg [7:0] data_in;
    wire [7:0] data_out;
    wire is_empty;
    wire is_full;

    // Instantiate the queue module
    queue uut (
        .clk(clk),
        .rst(rst),
        .enqueue(enqueue),
        .dequeue(dequeue),
        .peek(peek),
        .data_in(data_in),
        .data_out(data_out),
        .is_empty(is_empty),
        .is_full(is_full)
    );

    // Clock generation
    always #5 clk = ~clk; // 10ns clock period

    initial begin
        $monitor("Time = %0t | rst=%b | enqueue=%b | dequeue=%b | peek=%b | data_in=%h | data_out=%h | is_empty=%b | is_full=%b | top=%d",
                 $time, rst, enqueue, dequeue, peek, data_in, data_out, is_empty, is_full, uut.top);
        
        clk = 0;
        rst = 1;
        enqueue = 0;
        dequeue = 0;
        peek = 0;
        data_in = 8'b00000000;

        #10 rst = 0;
        
        $display("Enqueueing a few");
        #10 enqueue = 1; data_in = 8'h11; #10;
        #10 data_in = 8'h22; #10;
        #10 data_in = 8'h33; #10;
        #10 data_in = 8'h44; #10;
        #10 enqueue = 0;

        $display("Peek test");
        #10 peek = 1; #10 peek = 0;

        $display("Dequeueing");
        #10 dequeue = 1; #10;
        #10 dequeue = 1; #10;
        #10 dequeue = 1; #10;
        #10 dequeue = 1; #10 dequeue = 0;

        $display("is_empty test");
        #10 dequeue = 1; #10 dequeue = 0;

        $display("Enqueueing to full");
        #10 enqueue = 1;
        #10 data_in = 8'h55; #10;
        #10 data_in = 8'h66; #10;
        #10 data_in = 8'h77; #10;
        #10 data_in = 8'h88; #10;
        #10 data_in = 8'h99; #10;
        #10 data_in = 8'hAA; #10;
        #10 data_in = 8'hBB; #10;
        #10 data_in = 8'hCC; #10;
        #10 enqueue = 0;

        $display("enqueue on full queue");
        #10 enqueue = 1; data_in = 8'hDD; #10 enqueue = 0;

        $display("Dequeue all elements");
        repeat(8) begin
            #10 dequeue = 1; #10 dequeue = 0;
        end

        #10 $finish;
    end
endmodule