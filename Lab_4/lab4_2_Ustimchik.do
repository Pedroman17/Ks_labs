vsim work.f4_1
add wave sim:/f4_1/*
force x1 0 0ns, 1 40ns, 0 60ns, 1 80ns, 1 100ns, 1 120ns, 1 140ns, 1 160ns;
force x2 0 0ns, 0 40ns, 1 60ns, 0 80ns, 1 100ns, 1 120ns, 1 140ns, 1 160ns;
force x3 0 0ns, 1 40ns, 0 60ns, 1 80ns, 0 100ns, 1 120ns, 1 140ns, 1 160ns;
run 500ns
