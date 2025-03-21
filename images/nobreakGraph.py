import pandas as pd
from datetime import date
import matplotlib.pyplot as plt
import matplotlib.dates as mdates
import datetime
import time

while(1):
    data = []
    with open('upslog.txt', 'r') as f:
        for line in f:
            parts = line.split()
            if len(parts) >= 4:
                data.append([parts[0], ' '.join(parts[1:3]), parts[3]])
            else:
                print(f"Skipping line: {line.strip()}")

    df = pd.DataFrame(data, columns=['Day', 'Hour:Min:Sec', 'Voltage'])

    today = date.today()
    df['Day'] = pd.to_datetime(df['Day'], format='%Y%m%d', errors='coerce')
    df_today = df[df['Day'].dt.date == today]

    df_today['Hour:Min:Sec'] = df_today['Hour:Min:Sec'].str.split().str[0]
    df_today.loc[:, 'Time'] = pd.to_datetime(df_today['Hour:Min:Sec'], format='%H%M%S', errors='coerce').dt.time
    df_today.loc[:, 'Voltage'] = pd.to_numeric(df_today['Voltage'], errors='coerce')
    df_visualization = df_today[['Time', 'Voltage']].copy()

    df_visualization['DateTime'] = df_visualization['Time'].apply(lambda x: datetime.datetime.combine(datetime.date.today(), x))

    plt.figure(figsize=(11, 5))
    plt.plot(df_visualization['DateTime'], df_visualization['Voltage'])

    plt.gca().xaxis.set_major_formatter(mdates.DateFormatter('%H:%M:%S'))
    plt.gcf().autofmt_xdate()

    plt.xlabel('Tempo')
    plt.ylabel('Tensao')
    plt.title('Historico de tensao do nobreak')
    plt.grid(True)
    plt.savefig('voltage_graph.png')
    time.sleep(200)
