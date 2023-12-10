import psutil
import subprocess
import time
from datetime import datetime

def log_message(message):
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    print(f"{timestamp}: {message}")

threshold_percentage = 70
excluded_processes = ['devenv.exe', 'HopToDesk.exe', 'msedge.exe', 'chrome.exe', 'TITAN_PRIVAT.exe']  # List of process names to exclude

while True:
    log_message("Starting a new iteration of the monitoring loop.")
    
    # Log overall system resource utilization
    log_message(f"System CPU Usage: {psutil.cpu_percent()}%, Memory Usage: {psutil.virtual_memory().percent}%")

    for process in psutil.process_iter(['pid', 'name', 'cpu_percent']):
        process_name = process.info['name']
        process_pid = process.info['pid']
        cpu_percent = process.info['cpu_percent']
        if process_name not in ['Idle', 'System Idle Process'] and cpu_percent > threshold_percentage and process_name not in excluded_processes:
            log_message(f"High CPU Usage detected in process: {process_name} (PID: {process_pid}, CPU: {cpu_percent}%)")
            try:
                subprocess.run(['taskkill', '/F', '/IM', process_name], check=True)
                log_message(f"Terminated process: {process_name} (PID: {process_pid})")
                
            except subprocess.CalledProcessError as e:
                log_message(f"Failed to terminate process: {process_name} (PID: {process_pid}). Error: {e}")

    log_message("Completed an iteration of the monitoring loop.")
    time.sleep(10)  # Adjust the sleep duration as needed
