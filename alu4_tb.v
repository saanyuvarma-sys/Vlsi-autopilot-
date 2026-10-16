
module alu4_tb;
    reg [3:0] a, b;
    reg [1:0] op;
    wire [3:0] y;
    wire carry;
    integer i, j, k;
    integer errors = 0;
    integer total = 0;
    reg [4:0] expected;

    alu4 dut(.a(a), .b(b), .op(op), .y(y), .carry(carry));

    initial begin
        for (k = 0; k < 4; k = k + 1) begin
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    a = i;
                    b = j;
                    op = k;
                    #1;
                    total = total + 1;

                    case (k)
                        0: expected = i + j;
                        1: expected = (i - j) & 15;
                        2: expected = i & j;
                        3: expected = i ^ j;
                    endcase

                    if (y !== expected[3:0] ||
                        carry !== (k == 0 ? expected[4] : 1'b0)) begin
                        errors = errors + 1;
                        if (errors <= 10)
                            $display("FAIL a=%d b=%d op=%d y=%d carry=%b",
                                     a, b, op, y, carry);
                    end
                end
            end
        end

        $display("TOTAL_TESTS=%0d", total);
        $display("ERRORS=%0d", errors);
        if (errors == 0)
            $display("RESULT=PASS");
        else
            $display("RESULT=FAIL");
        $finish;
    end
endmodule
