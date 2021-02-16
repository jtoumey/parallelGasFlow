import sys
import matplotlib.pyplot as plt

def main():
    # The log file must be supplied as a command line argument.
    # If it is not found, exit gracefully
    try:
        fhandle = open(sys.argv[1])
    except IOError:
        print("Error: File not present.")
        sys.exit(1)

    file_contents = fhandle.readlines()

    time_step_idx = []
    n = 0
    first_loop_flag = 1
    line_idx = 0
    dt_all = []

    cfl_number = []
    clock_time = []
    time_step = []
    t_m1 = 0.0
    physicalTime = []

    # Future implementation
    # params = ['Courant', 'ExecutionTime']

    for line in file_contents:
        if 'Courant' in line:
            # Extract the numeric value of CFL from the CFL line entry
            cfl_max_idx = line.find('max')
            cfl_max_idx = cfl_max_idx + 5
            line = float(line[cfl_max_idx:])

            cfl_number.append(line)

            # Append the index of this CFL number to use for plotting as the
            # independent variable
            time_step_idx.append(n)
            n = n + 1

        elif 'ExecutionTime' in line:
            # Extract the numeric value of the execution time for the current
            # time-step
            execution_time_idx = line.find('ExecutionTime')
            execution_time_idx = execution_time_idx + len('ExecutionTime') + 3
            end = line.find('ClockTime') - 4
            current_time = float(line[execution_time_idx:end])

            # Compute the time-step size, save a new t_m1
            time_step_size = current_time - t_m1
            time_step.append(time_step_size)
            t_m1 = current_time

            clock_time.append(current_time)

        elif line.startswith('Time = '):
            # Get the current simulation time
            t_current = float(line[7:])
            physicalTime.append(t_current)
            if first_loop_flag == 1:
                dt_m1 = t_current
                first_loop_flag = 0
            else:
                dtt = t_current - dt_m1
                dt_all.append(dtt)
                dt_m1 = t_current

        line_idx = line_idx + 1

    # If the file was written halfway through a time-step calculation,
    # the arrays may be different sizes. If this is the case, pop the value
    # from the longer array. NOTE: Assumes arrays differ by in length by one
    if len(clock_time) > len(cfl_number):
        while len(clock_time) > len(cfl_number):
            clock_time.pop()
            physicalTime.pop()
    if len(cfl_number) > len(clock_time):
        while len(cfl_number) > len(clock_time):
            cfl_number.pop()

    print(len(clock_time), len(cfl_number))

    wc_average = sum(time_step)/len(time_step)
    dt_average = sum(dt_all)/len(dt_all)
    max_cfl_average = sum(cfl_number)/len(cfl_number)
    max_cfl_max = max(cfl_number)

    print("===================================================")
    print(" Average wallclock/time-step: {}".format(wc_average))
    print("      Average time-step size: {}".format(dt_average))
    print(" Wallclock for 1 sim-sec [s]: {}".format(wc_average/dt_average))
    print(" Wallclock for 1 sim-sec [d]: {}".format(wc_average/dt_average/(3600*24)))
    print("      Average max CFL number: {}".format(max_cfl_average))
    print("      Maximum max CFL number: {}".format(max_cfl_max))

    # Plot the wallclock time
    fig1 = plt.figure(1)
    plt.plot(clock_time, cfl_number, linewidth=0.75)
    # Plot the time-step size
    physicalTime.pop()
    fig2 = plt.figure(2)
    plt.plot(physicalTime, time_step, linewidth=1.25)
    plt.xlabel('Physical Time (s)')
    plt.ylabel('Wall-Clock Time (s)')
    fig2.savefig(r'vt01_wallClockPerDeltaT.pdf', format='pdf', dpi=900)

    plt.show()

if __name__ == '__main__':
    main()
