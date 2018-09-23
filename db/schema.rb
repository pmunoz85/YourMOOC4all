# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180510110824) do

  create_table "audios", force: :cascade do |t|
    t.integer  "curso_id",   limit: 4
    t.integer  "idioma_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "audios", ["curso_id"], name: "index_audios_on_curso_id", using: :btree
  add_index "audios", ["idioma_id"], name: "index_audios_on_idioma_id", using: :btree

  create_table "cursos", force: :cascade do |t|
    t.string   "identificador",         limit: 255
    t.string   "url",                   limit: 255
    t.string   "nombre",                limit: 255
    t.integer  "proveedor_id",          limit: 4
    t.integer  "universidad_id",        limit: 4
    t.text     "tematica",              limit: 65535
    t.text     "informacion",           limit: 65535
    t.text     "conocimientos_previos", limit: 65535
    t.string   "esfuerzo_estimado",     limit: 255
    t.boolean  "lenguaje_signos"
    t.string   "precio_auditado",       limit: 255
    t.string   "precio_credencial",     limit: 255
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "imagen_file_name",      limit: 255
    t.string   "imagen_content_type",   limit: 255
    t.integer  "imagen_file_size",      limit: 4
    t.datetime "imagen_updated_at"
    t.string   "imagen_url",            limit: 255
    t.text     "objetivos",             limit: 65535
    t.text     "destinatarios",         limit: 65535
    t.text     "evaluacion",            limit: 65535
    t.text     "inicio",                limit: 65535
    t.boolean  "oculto"
    t.integer  "edicion_anterior_id",   limit: 4
    t.date     "fecha_inicio"
  end

  add_index "cursos", ["edicion_anterior_id"], name: "index_cursos_on_edicion_anterior_id", using: :btree
  add_index "cursos", ["proveedor_id"], name: "index_cursos_on_proveedor_id", using: :btree
  add_index "cursos", ["universidad_id"], name: "index_cursos_on_universidad_id", using: :btree

  create_table "cursos_users", id: false, force: :cascade do |t|
    t.integer "curso_id", limit: 4, null: false
    t.integer "user_id",  limit: 4, null: false
  end

  add_index "cursos_users", ["curso_id", "user_id"], name: "index_cursos_users_on_curso_id_and_user_id", using: :btree
  add_index "cursos_users", ["user_id", "curso_id"], name: "index_cursos_users_on_user_id_and_curso_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "evaluaciones", force: :cascade do |t|
    t.integer  "user_id",                   limit: 4
    t.integer  "curso_id",                  limit: 4
    t.integer  "motivacion_pregunta1",      limit: 4
    t.integer  "motivacion_pregunta2",      limit: 4
    t.integer  "motivacion_pregunta3",      limit: 4
    t.integer  "motivacion_pregunta4",      limit: 4
    t.integer  "motivacion_pregunta5",      limit: 4
    t.integer  "motivacion_pregunta6",      limit: 4
    t.integer  "motivacion_pregunta7",      limit: 4
    t.integer  "motivacion_pregunta8",      limit: 4
    t.integer  "motivacion_pregunta9",      limit: 4
    t.integer  "motivacion_pregunta10",     limit: 4
    t.text     "motivacion",                limit: 65535
    t.integer  "representacion_pregunta11", limit: 4
    t.integer  "representacion_pregunta12", limit: 4
    t.integer  "representacion_pregunta13", limit: 4
    t.integer  "representacion_pregunta14", limit: 4
    t.integer  "representacion_pregunta15", limit: 4
    t.integer  "representacion_pregunta16", limit: 4
    t.integer  "representacion_pregunta17", limit: 4
    t.integer  "representacion_pregunta18", limit: 4
    t.integer  "representacion_pregunta19", limit: 4
    t.integer  "representacion_pregunta20", limit: 4
    t.integer  "representacion_pregunta21", limit: 4
    t.integer  "representacion_pregunta22", limit: 4
    t.text     "representacion",            limit: 65535
    t.integer  "expresion_pregunta23",      limit: 4
    t.integer  "expresion_pregunta24",      limit: 4
    t.integer  "expresion_pregunta25",      limit: 4
    t.integer  "expresion_pregunta26",      limit: 4
    t.integer  "expresion_pregunta27",      limit: 4
    t.integer  "expresion_pregunta28",      limit: 4
    t.integer  "expresion_pregunta29",      limit: 4
    t.integer  "expresion_pregunta30",      limit: 4
    t.integer  "expresion_pregunta31",      limit: 4
    t.text     "expresion",                 limit: 65535
    t.text     "texto_libre",               limit: 65535
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "experiencia",               limit: 255
    t.string   "progreso",                  limit: 255
  end

  add_index "evaluaciones", ["curso_id"], name: "index_evaluaciones_on_curso_id", using: :btree
  add_index "evaluaciones", ["user_id"], name: "index_evaluaciones_on_user_id", using: :btree

  create_table "idiomas", force: :cascade do |t|
    t.string   "descripcion", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "proveedores", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.string   "url",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "resource_id",   limit: 4
    t.string   "resource_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "subtitulos", force: :cascade do |t|
    t.integer  "curso_id",   limit: 4
    t.integer  "idioma_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "subtitulos", ["curso_id"], name: "index_subtitulos_on_curso_id", using: :btree
  add_index "subtitulos", ["idioma_id"], name: "index_subtitulos_on_idioma_id", using: :btree

  create_table "transcripciones", force: :cascade do |t|
    t.integer  "curso_id",   limit: 4
    t.integer  "idioma_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "transcripciones", ["curso_id"], name: "index_transcripciones_on_curso_id", using: :btree
  add_index "transcripciones", ["idioma_id"], name: "index_transcripciones_on_idioma_id", using: :btree

  create_table "universidades", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.integer "role_id", limit: 4
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  add_foreign_key "audios", "cursos"
  add_foreign_key "audios", "idiomas"
  add_foreign_key "cursos", "proveedores"
  add_foreign_key "cursos", "universidades"
  add_foreign_key "evaluaciones", "cursos"
  add_foreign_key "evaluaciones", "users"
  add_foreign_key "subtitulos", "cursos"
  add_foreign_key "subtitulos", "idiomas"
  add_foreign_key "transcripciones", "cursos"
  add_foreign_key "transcripciones", "idiomas"
end
