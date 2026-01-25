cliente postgres
```sh
docker exec -it postgres psql -U postgres -d postgres
```
```sql
SELECT current_database();
```
docker
```sh
docker compose down -v                   
docker compose up -d
```
sql server test cliente
```sh
docker exec -it mssql-tools /opt/mssql-tools/bin/sqlcmd -S sqlserver -U sa -P 'Pi3141592654!' -Q "SELECT 1"
```
----


La idea clave es esta:

> **La imagen NUNCA se borra con `docker compose down`**
> Lo que cambia entre un *down* y otro es **si borras o no los volúmenes (datos)**.

Vamos a separar **claramente los escenarios** y te dejo la estructura recomendada.

---

# 🧠 Concepto correcto (importante)

Docker maneja **3 cosas distintas**:

1. **Imagen** → el motor (SQL Server / Postgres)
2. **Contenedor** → tu uso actual
3. **Volumen** → los datos

👉 **`docker compose down` JAMÁS borra imágenes**
👉 **Solo borra imágenes si tú explícitamente lo pides**

Así que para tu requerimiento:

| Acción               | Comando                   | ¿Datos?        | ¿Imagen?      |
| -------------------- | ------------------------- | -------------- | ------------- |
| Resetear uso (soft)  | `down`                    | ❌ NO se borran | ✅ Se conserva |
| Resetear todo (hard) | `down -v`                 | ✅ SE borran    | ✅ Se conserva |
| Borrar imágenes      | `docker rmi` / `prune -a` | 💀             | 💀            |

---

# 🧩 Escenario 1 — *Down suave* (pierdo uso, NO datos)

👉 **Uso típico diario**

```bash
docker compose down
```

✔ Se eliminan contenedores
✔ Se liberan puertos
✔ **Los datos quedan**
✔ **Las imágenes NO se tocan**

---

# 💣 Escenario 2 — *Down duro* (borro todo mi uso)

👉 **Quiero empezar desde cero**

```bash
docker compose down -v
```

✔ Se eliminan contenedores
✔ ❌ **Se borran volúmenes (datos)**
✔ ✅ **Las imágenes siguen intactas**

⚠️ **Esto es justo lo que tú pedías como “el otro down”**

---

# 🔒 Blindaje extra: evitar descargas accidentales

## 1️⃣ Usa `.env` (recomendado)

```env
MSSQL_SA_PASSWORD=SuperPassword123!
```

Y levantas con:

```bash
docker compose up -d
```

---

## 2️⃣ Regla de oro (muy importante)

🚫 **NO ejecutes nunca esto si quieres proteger imágenes**:

```bash
docker system prune -a
docker image prune -a
```

Si quieres limpiar sin tocar imágenes:

```bash
docker system prune
```

---

# 🧪 Verificación rápida (para tu tranquilidad)

```bash
docker images | grep mssql
docker images | grep postgres
```

Si aparecen ahí → **no se volverán a descargar** 💪

---

## 🧠 Resumen mental corto

* **Imagen = sagrada**
* `down` → pierdo uso
* `down -v` → pierdo uso + datos
* Solo tú puedes borrar imágenes

Si quieres, en el siguiente mensaje te puedo:

* separar esto en **compose.soft.yml** y **compose.hard.yml**
* crear **scripts `make down-soft` / `make down-hard`**
* o versionarlo para **dev / test / prod**
