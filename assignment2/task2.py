import numpy as np
import matplotlib.pyplot as plt


## Kalmanov filter

T = 1

# Definisanje sistema
A = np.array([
    [1, T, T**2/2],
    [0, 1, T],
    [0, 0, 1]
])

B = np.array([T**2/2, T, 1])

H = np.array([[1, 0, 0]])

def loadData(path):
    X = np.array([[float(x.strip()) for x in open(path).readlines()]])
    return X.T

def simulateKalman(X, s0, M0, sigma_u, sigma_w):
    N, _ = X.shape
    
    s    = np.zeros((N, 3, 1))
    s[0] = s0

    M    = np.zeros((N, 3, 3))
    M[0] = M0

    K = np.zeros((N, 3, 1))

    Q = sigma_u
    C = sigma_w


    for n in range(1, N): 
        s[n] = A @ s[n - 1]
        M[n] = A @ M[n - 1] @ A.T + B * Q @ B.T

        K[n] = M[n] @ H.T / (C + H @ M[n] @ H.T)

        s[n] = s[n] + K[n] * (X[n] - H @ s[n])
        # M[n] = (np.eye(3) - K[n] @ H) @ M[n]
        
        M[n] = M[n] - (K[n] @ H) @ M[n]

    return s, M


if __name__ == "__main__":
    X = loadData('gps_data.txt')
    s0 = np.array([[0, 0, 0]]).T
    M0 = np.eye(3)

    sigma_w = 1
    sigma_u = 0#.2**2

    ss, M = simulateKalman(X, s0, M0, sigma_u, sigma_w)

    plt.plot(X, 'black')
    plt.plot(ss[:, 0], 'r')
    plt.show()