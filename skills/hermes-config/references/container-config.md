# Container Configuration Reference

Docker and container settings for code execution.

```yaml
container_memory: 5120
container_disk: 51200
container_persistent: true
docker_volumes: []
docker_mount_cwd_to_workspace: false
docker_run_as_host_user: false
```

## Configuration Options

| Setting | Type | Default | Description |
|---------|------|---------|-------------|
| `container_memory` | int | 5120 | Memory limit in MB |
| `container_disk` | int | 51200 | Disk limit in MB |
| `container_persistent` | bool | true | Keep container between runs |
| `docker_volumes` | array | [] | Additional volume mounts |
| `docker_mount_cwd_to_workspace` | bool | false | Mount current directory |
| `docker_run_as_host_user` | bool | false | Run as host UID |

## Docker Volume Mounts

```yaml
docker_volumes:
  - /host/path:/container/path
  - ~/.hermes:/root/.hermes
```