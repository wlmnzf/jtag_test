; this part encodes a partial order on labels
(declare-sort Label)
(declare-fun leq (Label Label) Bool)
(declare-fun join (Label Label) Label)
(declare-fun meet (Label Label) Label)
(assert (forall ((x Label)) (leq x x)))
(assert (forall ((x Label) (y Label) (z Label)) (implies (and (leq x y) (leq y z)) (leq x z))))
(assert (forall ((x Label) (y Label)) (implies (and (leq x y) (leq y x)) (= x y))))

; axioms for join
(assert (forall ((x Label) (y Label) (z Label)) (implies (leq (join x y) z) (and (leq x z) (leq y z)))))
(assert (forall ((x Label) (y Label) (z Label)) (implies (and (leq x z) (leq y z)) (leq (join x y) z))))
(assert (forall ((x Label) (y Label)) (and (leq x (join x y)) (leq y (join x y)))))
(assert (forall ((x Label) (y Label)) (= (join x y) (join y x))))

; axioms for meet
(assert (forall ((x Label) (y Label) (z Label)) (implies (leq x (meet y z)) (and (leq x y) (leq x z)))))
(assert (forall ((x Label) (y Label) (z Label)) (implies (and (leq x y) (leq x z)) (leq x (meet y z)))))
(assert (forall ((x Label) (y Label)) (and (leq (meet x y) x) (leq (meet x y) y))))
(assert (forall ((x Label) (y Label)) (= (meet x y) (meet y x))))

; lattice elements
(declare-fun LOW () Label)
(declare-fun HIGH () Label)
(declare-fun D1 () Label)
(declare-fun D2 () Label)

; lattice structure
(assert (forall ((x Label)) (leq LOW x)))
(assert (forall ((x Label)) (leq x HIGH)))
(assert (not (= HIGH LOW))) ; the lattice cannot clapse

; new lattice elements L1 and L2
(declare-fun L1 () Label)
(declare-fun L2 () Label)

; lattice structure
(assert (leq L1 L2))

; variables to be solved

; function that maps 0 to LOW; 1 to HIGH
(declare-fun LH (Int) Label)
(assert (= (LH 0) LOW))
(assert (= (LH 1) HIGH))
; Domain(0)=L1, Domain(1)=L2
(declare-fun Domain (Int) Label)
(assert (= (Domain 0) L1))
(assert (= (Domain 1) L2))

; assertions to be verified

(push)
(assert  (not(leq HIGH  HIGH)))    ; assign bypass_gate = and (and (shift_dr) (sel_bypass)) (bypass_so) @xgate_jtag.v:472
(check-sat)
(pop)


(push)
(assert  (not(leq HIGH  HIGH)))    ; assign bsd_gate = and (and (shift_dr) (sel_bsd)) (bsd_so) @xgate_jtag.v:473
(check-sat)
(pop)


(push)
(assert  (not(leq HIGH  HIGH)))    ; assign id_gate = and (and (shift_dr) (sel_id)) (id_so) @xgate_jtag.v:474
(check-sat)
(pop)


(push)
(assert  (not(leq HIGH  HIGH)))    ; assign udi_1_gate = and (and (shift_dr) (sel_udi_1)) (user1_so) @xgate_jtag.v:475
(check-sat)
(pop)


(push)
(assert  (not(leq HIGH  HIGH)))    ; assign ir_gate = and (shift_ir) (ir_so) @xgate_jtag.v:476
(check-sat)
(pop)


(push)
(assert  (not(leq HIGH  HIGH)))    ; assign jtag_tdo_mux = or (or (or (or (bypass_gate) (bsd_gate)) (id_gate)) (udi_1_gate)) (ir_gate) @xgate_jtag.v:478
(check-sat)
(pop)


(push)
(assert  (not(leq HIGH  HIGH)))    ; jtag_tdo <= 0 @xgate_jtag.v:483
(check-sat)
(pop)


(push)
(assert  (not(leq HIGH  HIGH)))    ; jtag_tdo <= jtag_tdo_mux @xgate_jtag.v:485
(check-sat)
(pop)


(push)
(assert  (not(leq HIGH  HIGH)))    ; jtag_tdo_en <= 0 @xgate_jtag.v:490
(check-sat)
(pop)


(push)
(assert  (not(leq HIGH  HIGH)))    ; jtag_tdo_en <= or (shift_dr) (shift_ir) @xgate_jtag.v:492
(check-sat)
(pop)

