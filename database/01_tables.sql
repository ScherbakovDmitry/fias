START TRANSACTION;

DROP TABLE IF EXISTS houses;
CREATE TABLE houses (
    id          UUID PRIMARY KEY NOT NULL,
    house_id    UUID             NOT NULL,
    address_id  UUID DEFAULT NULL,
    number      VARCHAR,
    full_number VARCHAR,
    building    VARCHAR,
    structure   VARCHAR,
    postal_code INTEGER
);
COMMENT ON TABLE  houses             IS 'данные по домам';
COMMENT ON COLUMN houses.id          IS 'идентификационный код записи';
COMMENT ON COLUMN houses.house_id    IS 'идентификационный код дома';
COMMENT ON COLUMN houses.address_id  IS 'идентификационный код адресного объекта';
COMMENT ON COLUMN houses.number      IS 'номер дома';
COMMENT ON COLUMN houses.building    IS 'корпус';
COMMENT ON COLUMN houses.structure   IS 'строение';
COMMENT ON COLUMN houses.postal_code IS 'индекс';

DROP TABLE IF EXISTS address_objects;
CREATE TABLE address_objects (
    id          UUID PRIMARY KEY NOT NULL,
    address_id  UUID             NOT NULL,
    parent_id   UUID             DEFAULT NULL,
    level       INTEGER,
    house_count INTEGER,
    title       VARCHAR,
    full_title  VARCHAR,
    postal_code INTEGER,
    prefix      VARCHAR
);
COMMENT ON TABLE address_objects              IS 'данные по адресным объектам(округам, улицам, городам)';
COMMENT ON COLUMN address_objects.id          IS 'идентификационный код записи';
COMMENT ON COLUMN address_objects.address_id  IS 'идентификационный код адресного объекта';
COMMENT ON COLUMN address_objects.parent_id   IS 'идентификационный код родительского адресного объекта';
COMMENT ON COLUMN address_objects.title       IS 'наименование объекта';
COMMENT ON COLUMN address_objects.full_title  IS 'полное наименование объекта';
COMMENT ON COLUMN address_objects.postal_code IS 'индекс';
COMMENT ON COLUMN address_objects.prefix      IS 'ул., пр. и так далее';
COMMENT ON COLUMN address_objects.house_count IS 'количество домов';

DROP TABLE IF EXISTS update_log;
CREATE TABLE update_log (
    id SERIAL PRIMARY KEY,
    version_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(0)
);
COMMENT ON TABLE update_log              IS 'лог обновлений';
COMMENT ON COLUMN update_log.version_id  IS 'id версии, полученной от базы ФИАС';
COMMENT ON COLUMN update_log.created_at  IS 'дата установки обновления/инициализации';

DROP TABLE IF EXISTS places;
CREATE TABLE places (
    id SERIAL PRIMARY KEY,
    title VARCHAR,
    full_title VARCHAR,
    parent_id INTEGER,
    type_id INTEGER NOT NULL
);
COMMENT ON TABLE places              IS 'справочник мест';
COMMENT ON COLUMN places.title       IS 'название места';
COMMENT ON COLUMN places.full_title  IS 'название места с типом';
COMMENT ON COLUMN places.parent_id   IS 'идентификатор родительского места';
COMMENT ON COLUMN places.type_id     IS 'идентификатор типа места';

DROP TABLE IF EXISTS place_types;
CREATE TABLE place_types(
    id SERIAL PRIMARY KEY,
    parent_id INTEGER,
    title VARCHAR NOT NULL UNIQUE,
    system_name VARCHAR UNIQUE
);
COMMENT ON TABLE place_types              IS 'справочник типов мест';
COMMENT ON COLUMN place_types.parent_id   IS 'идентификатор типа родителя';
COMMENT ON COLUMN place_types.title       IS 'название типа для пользователя';
COMMENT ON COLUMN place_types.system_name IS 'системное имя типа, для использования в программном коде';

COMMIT;
