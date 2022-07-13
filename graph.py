#!/usr/bin/env python3
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd


def get_df(fname):
    df = pd.read_csv(fname)
    df = df[df["status-code"] == 200]["response-time"]
    return df


bloc40 = get_df("bloc40.csv")
count_bloc40, bins_count_bloc40 = np.histogram(bloc40, bins=50)
pdf_bloc40 = count_bloc40 / sum(count_bloc40)
cdf_bloc40 = np.cumsum(pdf_bloc40)

lc40 = get_df("lc40.csv")
count_lc40, bins_count_lc40 = np.histogram(lc40, bins=50)
pdf_lc40 = count_lc40 / sum(count_lc40)
cdf_lc40 = np.cumsum(pdf_lc40)


lc1 = get_df("lc1.csv")
count_lc1, bins_count_lc1 = np.histogram(lc1, bins=50)
pdf_lc1 = count_lc1 / sum(count_lc1)
cdf_lc1 = np.cumsum(pdf_lc1)

plt.figure(figsize=(15, 8))
plt.plot(bins_count_lc40[1:], cdf_lc40,
         label="LeastConn with 40:10 Nodes", marker=".")
plt.plot(bins_count_lc1[1:], cdf_lc1,
         label="LeastConn with 1:10 Nodes", marker="v")
plt.plot(bins_count_bloc40[1:], cdf_bloc40,
         label="BLOC 40:10 Nodes", marker="s")

plt.legend()
plt.grid(True)
plt.ylabel("Percentile of Response")
plt.xlabel("Response Time (Seconds)")
plt.savefig("BLOCProxyVsLeastConn.pdf")
