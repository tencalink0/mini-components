module queue(
    input wire clk,
    input wire rst,
    input wire enqueue,
    input wire dequeue,
    input wire peek,
    input wire [7:0] data_in,
    output reg [7:0] data_out,
    output reg is_empty,
    output reg is_full
);
    reg [7:0] queue_mem [7:0];
    reg [3:0] top;
    integer i;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            top <= 3'b000;
            is_empty <= 1'b1;
            is_full <= 1'b0;
            data_out <= 8'b0000_0000;
        end
        else begin
            if (enqueue && top < 8) begin
                for (i = 7; i > 0; i = i - 1) begin
                    queue_mem[i] = queue_mem[i-1];
                end
                queue_mem[0] = data_in;
                top <= top + 1;
                is_empty <= 1'b0;
            end 
            else if (dequeue && top > 0) begin
                top = top - 1;
                data_out = queue_mem[top - 1];
                queue_mem[top] = 8'b0000_0000;
                is_empty <= 1'b0;
            end
            else if (peek && top > 0) begin
                data_out = queue_mem[top - 1];
            end

            if (top == 0) is_empty = 1'b1;
            if (top == 7) is_full = 1'b1;
        end
    end
endmodule