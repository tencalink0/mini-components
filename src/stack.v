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
            $display("Here1");
            sp <= 3'b000;
            empty <= 1'b1;
            data_out <= 8'b0; // Clear data_out on reset
        end
        else begin
            $display("Here3");
            if (push && sp < 8) begin
                $display("Here push");
                stack_mem[sp] <= data_in;
                sp <= sp + 1;
                empty <= 1'b0;
            end
            if (pop && sp > 0) begin
                $display("Here pop");
                sp <= sp - 1;
                data_out <= stack_mem[sp];
                if (sp == 1) empty <= 1'b1;
            end else if (sp == 0) begin
                empty <= 1'b1;
            end
        end
    end
endmodule