module divider(A, B, Z);
    input signed [31:0] A, B;
    output wire signed [63:0] Z;
    reg signed [31:0] Q, A_abs, B_abs;
    reg signed [32:0] M, M_twos, temp;
    reg [64:0] shifted;
    reg dividend_sign, divisor_sign;
    integer i;

    always @(A, B) begin
        // Determine the signs of the inputs
        dividend_sign = A[31];
        divisor_sign = B[31];

        // Convert A and B to their absolute values
        A_abs = dividend_sign ? -A : A;
        B_abs = divisor_sign ? -B : B;

        // Initialize for division
        M = B_abs;
        Q = A_abs;
        temp = 33'b0;
        M_twos = -M;

        for(i = 0; i < 32; i = i + 1) begin
            shifted = {temp, Q} << 1;
            temp = shifted[64:32];
            Q = shifted[31:0];

            if(temp[32]) begin
                temp = temp + M;
            end else begin
                temp = temp + M_twos;
            end

            Q[0] = ~temp[32];
        end

        // Final correction step, if necessary
        if(temp[32]) begin
            temp = temp + M;
        end

        // Adjust the sign of the quotient and remainder based on the original signs of A and B
        if(dividend_sign ^ divisor_sign) begin
            Q = -Q; // If A and B have different signs, the quotient should be negative
        end
        if(dividend_sign) begin
            temp = -temp; // The remainder should follow the sign of A
        end

        // Combine the quotient and adjusted remainder
        Z = {temp[31:0], Q};
    end
endmodule
