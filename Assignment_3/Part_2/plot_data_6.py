import matplotlib.pyplot as plt

data = []

with open("data.txt", "r") as file:
    for line in file:
        parts = line.strip().split()
        n = int(parts[0])
        duration1 = float(parts[1])
        duration2 = float(parts[2])
        duration3 = float(parts[3])
        data.append((n, duration1, duration2, duration3))

if data:
    ns = [entry[0] for entry in data]
    duration1 = [entry[1] for entry in data]
    duration2 = [entry[2] for entry in data]
    duration3 = [entry[3] for entry in data]

    plt.figure(figsize=(15, 6))
    plt.plot(ns, duration1, label="Duration i j k")
    plt.plot(ns, duration2, label="Duration k i j")
    plt.plot(ns, duration3, label="Duration k j i")
    plt.xlabel('n')
    plt.ylabel('Duration (microseconds)')
    plt.title('Duration vs n')
    plt.legend()
    plt.grid(True)

    plt.tight_layout()
    plt.savefig("plot_600.png")
    plt.show()
