-- RUN: docker-compose up -d --build

for M1 Mac

SQL server
    - docker pull mcr.microsoft.com/azure-sql-edge
    - docker run --cap-add SYS_PTRACE -e 'ACCEPT_EULA=1' -e 'MSSQL_SA_PASSWORD=Password.1' -p 1433:1433 --name azuresqledge-d mcr.microsoft.com/azure-sql-edge
