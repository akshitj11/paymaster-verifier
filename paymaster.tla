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
execute(o) ==
    /\op_status[o]="validated"
    /\op_status'=[op_status EXCEPT ![o]= "executed"]
    /\ UNCHANGED paymaster_deposit    
pause(o)==
    /\ op_status[o]="pending"
    /\ paymaster_deposit<gas_per_op
    /\op_status'=[op_status EXCEPT ![o]="pausd"]
    /\ UNCHANGED paymaster_deposit
next ==
    \E o \in ops:
    \/ validate(o)
    \/execute(o)
    \/pause(o)    
noexecutionwithoutFunds ==
  \A o \in ops :
    op_status[o]="executed"=> paymaster_deposit>=0
====
