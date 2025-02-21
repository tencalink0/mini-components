// Yes, I am aware that stacks are a software concept
// but I wanted to try and make a hardware implementation of them

module stack (
    input wire clk, 
    input wire reset,
    input wire push,
    input wire pop,
    input wire [7:0] data_in,
    output reg [7:0] data_out,
    output reg empty
);
    reg [7:0] stack_mem [7:0];
    reg [2:0] sp; // stack pointer
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            sp <= 3'b000;
            empty <= 1'b1;
            data_out <= 8'b0; // Clear data_out on reset
        end
        else begin
            if (push && sp < 8) begin
                stack_mem[sp] <= data_in;
                sp = sp + 1; // blocking assignment to update sp
                empty <= 1'b0;
                $display("Here push %b, %b", stack_mem[0], sp);
            end
            if (pop && sp > 0) begin
                sp = sp - 1;
                data_out <= stack_mem[sp];
                if (sp == 1) empty <= 1'b1;
                $display("Here pop %b, %b", stack_mem[0], sp);
            end else if (sp == 0) begin
                empty <= 1'b1;
            end
        end
    end
endmodule