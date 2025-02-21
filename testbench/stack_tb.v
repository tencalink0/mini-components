module stack_tb;
    reg clk, reset, push, pop;
    reg [7:0] data_in;

    wire [7:0] data_out;
    wire empty;

    stack stack_inst (
        .clk(clk),
        .reset(reset),
        .push(push),
        .pop(pop),
        .data_in(data_in),
        .data_out(data_out),
        .empty(empty)
    );

    always begin
        #5 clk = ~clk;
    end

    initial begin
        $monitor("push: %b | pop: %b | reset: %b | data_out: %b | empty: %b", push, pop, reset, data_out, empty);
        clk = 0;
        reset = 0;
        push = 0;
        pop = 0;
        data_in = 0;
        #10;

        reset = 1;
        #10;

        reset = 0;
        push = 1;
        data_in = 8'hA4;
        #10;

        push = 0;
        pop = 1;
        #10;

        pop = 0;
        #10;

        push = 1;
        data_in = 8'hC2;
        #10;

        push = 0;
        pop = 1;
        #10;

        $finish;
    end
endmodule