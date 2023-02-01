exit 0

# attach VTune to a running remote process
/opt/intel/oneapi/vtune_profiler/2022.1.0/MacOS/vtune  -target-system=ssh:dskravchenko@onprem -collect hotspots -target-tmp-dir=/tmp -target-install-dir=/home/dskravchenko/.vtune -target-pid 38714

# perf tools:
# needs -fno-omit-frame-pointer compilation flag
perf record -g ./main.cpp  # can also attach
perf report -g "graph,0.5,caller". # for assembly press 'a' inside

# run prometheus server
./prometheus --config.file=prometheus.yml --web.listen-address="[::]:9090"  # on remote
ssh -N -f -L localhost:9090:localhost:9090 dskravchenko@onprem  # on host
