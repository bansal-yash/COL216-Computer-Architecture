import matplotlib.pyplot as plt

data = []

with open("data.txt", "r") as file:
    for line in file:
        parts = line.strip().split()
        n = int(parts[0])
        duration1 = float(parts[1])
        duration2 = float(parts[2])
        data.append((n, duration1, duration2))

if data:
    ns = [entry[0] for entry in data]
    duration1 = [entry[1] for entry in data]
    duration2 = [entry[2] for entry in data]

    plt.figure(figsize=(15, 6))
    plt.plot(ns, duration1, label="Duration i j")
    plt.plot(ns, duration2, label="Duration j k")
    plt.xlabel('n')
    plt.ylabel('Duration (microseconds)')
    plt.title('Duration vs n')
    plt.legend()
    plt.grid(True)

    plt.tight_layout()
    plt.savefig("plot_5000.png")
    plt.show()
