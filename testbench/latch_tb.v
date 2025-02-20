module latch_tb;
    reg data, rw;
    wire out1, out2;

    d_latch d_latch_inst (
        .data(data),
        .rw(rw),
        .out(out1)
    );

    and_or_latch and_or_latch_inst (
        .set(data),
        .reset(rw),
        .out(out2)
    );

    initial begin
        $monitor("data / set: %b, rw / reset: %b, d_latch: %b, and_or_latch: %b", data, rw, out1, out2);
    
        data = 0; rw = 0; #10;
        data = 0; rw = 1; #10;
        data = 1; rw = 1; #10;
        data = 1; rw = 0; #10;
        data = 0; rw = 1; #10;
    end
endmodule