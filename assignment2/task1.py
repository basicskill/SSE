import numpy as np
import matplotlib.pyplot as plt
from numpy.random import normal
from scipy.stats import norm

phi   = 1
f     = 0.2
A     = 1
sigma = 0.5
K     = 2*np.pi*f
N     = 100

def l(X, phi):
    """
    log-likelihood function of vector X over parameter phi
    """

    N, = np.shape(X)
    return -1/(2*sigma**2) * np.sum(np.power(X - np.cos(K*np.arange(N, dtype=float) + phi), 2))

def l_prim(X, phi):
    """
    first derivative of log-likelihood function 
    of vector X over parameter phi
    """

    N, = np.shape(X)
    X_ = X - np.cos(K*np.arange(N, dtype=float) + phi)
    return (-1/sigma**2) * X_ @ np.sin(K*np.arange(N, dtype=float) + phi)

def l_sec(X, phi):
    """
    second derivative of log-likelihood function 
    of vector X over parameter phi
    """

    N, = np.shape(X)
    n = np.arange(N, dtype=float)
    c = np.cos(K*n + phi)
    s = np.sin(K*n + phi)

    return (-1/sigma**2) * (s.T @ s + (X - c).T @ c)

def plotLogLikelihood():
    w = normal(0, np.sqrt(sigma), N)
    X = A*np.cos(K*np.arange(N, dtype=float) + phi) + w

    phi_arr = np.arange(-5, 5, 0.2)

    L       = [l(X, phi)        for phi in phi_arr]
    L_prim  = [l_prim(X, phi)   for phi in phi_arr]
    L_sec   = [l_sec(X, phi)    for phi in phi_arr]

    plt.subplot(311)
    plt.plot(phi_arr, L)

    plt.subplot(312)
    plt.plot(phi_arr, L_prim)

    plt.subplot(313)
    plt.plot(phi_arr, L_sec)
    plt.show()


def NewtRaph(X, phi_start):

    phi_est = [phi_start]

    for _ in range(12):
        phi_k   = phi_est[-1]
        step    = l_prim(X, phi_k) / l_sec(X, phi_k)

        phi_est.append(phi_k - step) 

    return phi_est

def task2():
    phi_starts = [0, 1, 2]
    c = A*np.cos(K*np.arange(N, dtype=float) + phi)

    for idx, phi_start in enumerate(phi_starts):
        plt.subplot(3, 1, idx + 1)
        plt.ylim(top=6)
        plt.ylim(bottom=-1)
        for _ in range(5):
            w   = normal(0, sigma, N)
            X   = c + w
            est = NewtRaph(X, phi_start)
            plt.plot(est)

    plt.show()


if __name__ == "__main__":
    Nr = 1000
    phi_0 = 0.5
    s_w = 0.1
    N = 10

    c = A*np.cos(K*np.arange(N, dtype=float) + phi)
    est = []

    for _ in range(Nr):
        w   = normal(0, s_w, N)
        X   = c + w
        est.append(NewtRaph(X, phi_0)[-1])

    FI = np.sqrt((N*A/(2 * (s_w ** 2)))**(-1))
    x = np.linspace(.9, 1.1, 100)
    
    plt.hist(est, density=True, range=(.9, 1.1))
    plt.plot(x, norm.pdf(x, phi, FI))
    plt.show()