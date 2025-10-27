import mysql.connector

# ---------- CONFIGURACIÓN DE CONEXIÓN ----------
DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "123460",  # Reemplaza por tu contraseña real
    "database": "cliente_db"
}

# ---------- FUNCIÓN DE CONEXIÓN ----------
def conectar():
    """Crea y devuelve una conexión a MySQL usando los parámetros definidos en DB_CONFIG."""
    return mysql.connector.connect(**DB_CONFIG)

# ================= FUNCIONES GENERALES =================

def ejecutar_sp_listar(sp_name):
    """Ejecuta un SP de listado y muestra resultados en consola."""
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc(sp_name)
        for result in cur.stored_results():
            filas = result.fetchall()
            if filas:
                for fila in filas:
                    print(fila)
            else:
                print("No hay registros.")
    except mysql.connector.Error as e:
        print(f"❌ Error al ejecutar {sp_name}:", e)
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()


def ejecutar_sp_borrado(sp_name, id_):
    """Ejecuta un SP de borrado lógico por ID."""
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc(sp_name, [id_])
        cnx.commit()
        print(f"✅ Registro con ID {id_} eliminado lógicamente (si existía).")
    except mysql.connector.Error as e:
        print(f"❌ Error al ejecutar {sp_name}:", e)
        if cnx and cnx.is_connected():
            try: cnx.rollback()
            except: pass
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()


def ejecutar_sp_restaurar(sp_name, id_):
    """Ejecuta un SP de restauración por ID (si aplica)."""
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc(sp_name, [id_])
        cnx.commit()
        print(f"✅ Registro con ID {id_} restaurado (si estaba eliminado).")
    except mysql.connector.Error as e:
        print(f"❌ Error al ejecutar {sp_name}:", e)
        if cnx and cnx.is_connected():
            try: cnx.rollback()
            except: pass
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()


# ================== MENÚ POR TABLA ==================

def menu_tabla(tabla, sp_listar, sp_insertar=None, sp_borrar=None, sp_restaurar=None, campos_insertar=None):
    """
    Menú interactivo para cada tabla.
    - tabla: nombre de la tabla (para mostrar en encabezados)
    - sp_listar: SP para listar registros
    - sp_insertar: SP para insertar (opcional)
    - sp_borrar: SP para borrado lógico (opcional)
    - sp_restaurar: SP para restaurar (opcional)
    - campos_insertar: lista de nombres de campos a solicitar al usuario (si aplica insert)
    """
    while True:
        print(f"\n===== MENÚ {tabla.upper()} =====")
        print("1) Listar registros")
        if sp_insertar: print("2) Insertar registro")
        if sp_borrar: print("3) Borrar lógicamente registro")
        if sp_restaurar: print("4) Restaurar registro")
        print("0) Volver al menú principal")

        opcion = input("Selecciona una opción: ").strip()

        if opcion == "1":
            ejecutar_sp_listar(sp_listar)

        elif opcion == "2" and sp_insertar:
            valores = []
            for campo in campos_insertar:
                valor = input(f"{campo}: ").strip()
                valores.append(valor)
            # Convertir posibles números
            for i, v in enumerate(valores):
                if v.isdigit():
                    valores[i] = int(v)
            cnx = cur = None
            try:
                cnx = conectar()
                cur = cnx.cursor()
                cur.callproc(sp_insertar, valores)
                cnx.commit()
                print("✅ Registro insertado correctamente.")
            except mysql.connector.Error as e:
                print(f"❌ Error al insertar: {e}")
            finally:
                if cur: cur.close()
                if cnx and cnx.is_connected(): cnx.close()

        elif opcion == "3" and sp_borrar:
            try:
                id_ = int(input("ID a eliminar: ").strip())
                ejecutar_sp_borrado(sp_borrar, id_)
            except ValueError:
                print("❌ ID inválido.")

        elif opcion == "4" and sp_restaurar:
            try:
                id_ = int(input("ID a restaurar: ").strip())
                ejecutar_sp_restaurar(sp_restaurar, id_)
            except ValueError:
                print("❌ ID inválido.")

        elif opcion == "0":
            break
        else:
            print("❌ Opción no válida.")


# ================== MENÚ PRINCIPAL ==================

def menu_principal():
    while True:
        print("\n===== MENÚ PRINCIPAL CLIENTE_DB =====")
        print("1) Personas")
        print("2) Cargos")
        print("3) Salas")
        print("4) Tipo Usuarios")
        print("5) Usuarios")
        print("6) Tipo Dispositivos")
        print("7) Dispositivos")
        print("8) Estados Solicitud")
        print("9) Solicitudes")
        print("10) Estado Mantenimientos")
        print("11) Mantenimientos")
        print("0) Salir")

        opcion = input("Selecciona una tabla: ").strip()

        if opcion == "1":
            menu_tabla("Personas", "sp_listar_todo_personas",
                    sp_insertar="sp_insertar_persona",
                    sp_borrar="sp_borrar_persona",
                    campos_insertar=["nombres","apellidos","rut","telefono","direccion","correo"])

        elif opcion == "2":
            menu_tabla("Cargos", "sp_listar_cargos",
                    sp_insertar="sp_insertar_cargo",
                    sp_borrar="sp_borrar_cargo",
                    campos_insertar=["nombre_cargo","descripcion"])

        elif opcion == "3":
            menu_tabla("Salas", "sp_listar_todo_salas",
                    sp_insertar="sp_insertar_sala",
                    sp_borrar="sp_borrar_sala",
                    campos_insertar=["nombre_sala","ubicacion","cantidad_dispositivos"])

        elif opcion == "4":
            menu_tabla("Tipo Usuarios", "sp_listar_todo_tipo_usuarios",
                    sp_insertar="sp_insertar_tipo_usuario",
                    sp_borrar="sp_borrar_tipo_usuario",
                    campos_insertar=["nombre_tipo","descripcion_tipo"])

        elif opcion == "5":
            menu_tabla("Usuarios", "sp_listar_todo_usuarios",
                    sp_insertar="sp_insertar_usuario",
                    sp_borrar="sp_borrar_usuario",
                    campos_insertar=["nombre_usuario","contraseña","correo","rol","personas_id_persona","salas_idsalas"])

        elif opcion == "6":
            menu_tabla("Tipo Dispositivos", "sp_listar_todo_tipos_dispositivos",
                    sp_insertar="sp_insertar_tipo_dispositivo",
                    sp_borrar="sp_borrar_tipo_dispositivo",
                    campos_insertar=["nombre_tipo","descripcion"])
        elif opcion == "7":
            menu_tabla("Dispositivos", "sp_listar_todo_dispositivos",
                    sp_insertar="sp_insertar_dispositivo",
                    sp_borrar="sp_borrar_dispositivo",
                    campos_insertar=["nombre_dispositivo","estado_dispositivo","tipo_dispositivos_idtipo_dispositivo","salas_idsalas"])

        elif opcion == "8":
            menu_tabla("Estados Solicitud", "sp_listar_todo_estados_solicitud",
                    sp_insertar="sp_insertar_estado_solicitud",
                    sp_borrar="sp_borrar_estado_solicitud",
                    campos_insertar=["nombre_estado","descripcion"])

        elif opcion == "9":
            menu_tabla("Solicitudes", "sp_listar_todo_solicitudes",
                    sp_insertar="sp_insertar_solicitud",
                    sp_borrar="sp_borrar_solicitud",
                    campos_insertar=["titulo","descripcion","fecha_solicitud","estados_solicitud_id","usuarios_id_usuario"])
        elif opcion == "10":
            menu_tabla("Estado Mantenimientos", "sp_listar_todo_estado_mantenimientos",
                    sp_insertar="sp_insertar_estado_mantenimiento",
                    sp_borrar="sp_borrar_estado_mantenimiento",
                    campos_insertar=["nombre_estado","descripcion"])

        elif opcion == "11":
            menu_tabla("Mantenimientos", "sp_listar_todo_mantenimientos",
                    sp_insertar="sp_insertar_mantenimiento",
                    sp_borrar="sp_borrar_mantenimiento",
                    campos_insertar=["fecha","observaciones","encargado_usuario_id","estado_mantenimientos_id","dispositivos_iddispositivo"])

        elif opcion == "0":
            print("👋 Saliendo del sistema...")
            break
        else:
            print("❌ Opción no válida.")

# Punto de entrada
if __name__ == "__main__":
    menu_principal()