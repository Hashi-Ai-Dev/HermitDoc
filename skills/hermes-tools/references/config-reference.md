# Tool Configuration Schema

Configuration options for tools in config.yaml.

## Tool Configuration

```yaml
# config.yaml
tools:
  profile: "coding"  # minimal, coding, messaging, full
  # Or individual:
  enabled:
    - terminal
    - file
    - web
```

## Code Execution Mode

```yaml
code_execution:
  mode: project           # how code execution is sandboxed
```

## Tool Configuration Reference

| Setting | Type | Default | Description |
|---------|------|---------|-------------|
| `tools.profile` | string | "full" | Predefined tool set: minimal, coding, messaging, full |
| `tools.enabled` | array | all | List of enabled tools |
| `code_execution.mode` | string | "project" | Sandboxing mode for code execution |

## Container Configuration

```yaml
container_memory: 5120
container_disk: 51200
container_persistent: true
docker_volumes: []
docker_mount_cwd_to_workspace: false
docker_run_as_host_user: false
```

| Setting | Type | Default | Description |
|---------|------|---------|-------------|
| `container_memory` | int | 5120 | Memory limit in MB |
| `container_disk` | int | 51200 | Disk limit in MB |
| `container_persistent` | bool | true | Keep container between runs |
| `docker_volumes` | array | [] | Additional volume mounts |
| `docker_mount_cwd_to_workspace` | bool | false | Mount current directory |
| `docker_run_as_host_user` | bool | false | Run as host UID |