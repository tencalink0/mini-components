module d_latch (
    input wire data,
    input wire rw,
    output reg out
);
    always @(*) begin
        if (rw) out = data;
    end
endmodule

module and_or_latch (
    input wire set,
    input wire reset,
    output reg out
);
    always @(*) begin
        if (reset) out = 0;
        else if (set) out = 1;
        else out = out;
    end
endmodule