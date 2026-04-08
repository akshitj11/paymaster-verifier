 ---- MODULE paymaster ----
VARIABLES paymaster_deposit, op_status
ops == {"op1","op2","op3"}
gas_per_op == 20

Init ==
    /\ paymaster_deposit = 100
    /\ op_status = [o \in ops |->"pending"]
validate(o) ==
    /\op_status[o]="pending"
    /\paymaster_deposit >= gas_per_op
    /\op_status'=[op_status EXCEPT ![o]="validated"]
    /\paymaster_deposit'=paymaster_deposit-gas_per_op
        
====
