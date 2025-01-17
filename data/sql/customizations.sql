-- This file is hand generated.

INSERT INTO "geodetic_crs" VALUES('OGC','CRS84','WGS 84 (CRS84)',NULL,NULL,'geographic 2D','EPSG','6424','EPSG','6326','EPSG','1262',NULL,0);

INSERT INTO "other_transformation" VALUES('PROJ','CRS84_TO_EPSG_4326','OGC:CRS84 to WGS 84',NULL,NULL,'EPSG','9843','Axis Order Reversal (2D)','OGC','CRS84','EPSG','4326','EPSG','1262',0.0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0);

-- alias of EPSG:3857
INSERT INTO "projected_crs" VALUES('EPSG','900913','Google Maps Global Mercator',NULL,NULL,'EPSG','4499','EPSG','4326','EPSG','3856','EPSG','3544',NULL,1);

-- ('EPSG','7001','ETRS89 to NAP height (1)') lacks an interpolationCRS with Amersfoort / EPSG:4289
-- See https://salsa.debian.org/debian-gis-team/proj-rdnap/blob/debian/2008-8/Use%20of%20RDTRANS2008%20and%20NAPTRANS2008.pdf
-- "The naptrans2008 VDatum-grid is referenced to the Bessel-1841 ellipsoid"
CREATE TABLE dummy(foo);
CREATE TRIGGER check_grid_transformation_epsg_7001
BEFORE INSERT ON dummy
FOR EACH ROW BEGIN
    SELECT RAISE(ABORT, 'grid_transformation EPSG:7001 entry is not ETRS89 to NAP height (1)')
        WHERE NOT EXISTS(SELECT 1 FROM grid_transformation WHERE auth_name = 'EPSG' AND code = '7001' AND name = 'ETRS89 to NAP height (1)');
    SELECT RAISE(ABORT, 'grid_transformation EPSG:7001 entry has already an interpolationCRS')
        WHERE EXISTS(SELECT 1 FROM grid_transformation WHERE auth_name = 'EPSG' AND code = '7001' AND interpolation_crs_auth_name IS NOT NULL);
END;
INSERT INTO dummy DEFAULT VALUES;
DROP TRIGGER check_grid_transformation_epsg_7001;
DROP TABLE dummy;
UPDATE grid_transformation SET interpolation_crs_auth_name = 'EPSG',
                               interpolation_crs_code = '4289'
                           WHERE auth_name = 'EPSG' AND code = '7001';

-- Define the allowed authorities, and their precedence, when researching a
-- coordinate operation

INSERT INTO authority_to_authority_preference(source_auth_name, target_auth_name, allowed_authorities) VALUES
    ('any', 'EPSG', 'PROJ,EPSG,any' );

INSERT INTO authority_to_authority_preference(source_auth_name, target_auth_name, allowed_authorities) VALUES
    ('EPSG', 'EPSG', 'PROJ,EPSG' );

INSERT INTO authority_to_authority_preference(source_auth_name, target_auth_name, allowed_authorities) VALUES
    ('PROJ', 'EPSG', 'PROJ,EPSG' );

INSERT INTO authority_to_authority_preference(source_auth_name, target_auth_name, allowed_authorities) VALUES
    ('IGNF', 'EPSG', 'PROJ,IGNF,EPSG' );

INSERT INTO authority_to_authority_preference(source_auth_name, target_auth_name, allowed_authorities) VALUES
    ('ESRI', 'EPSG', 'PROJ,ESRI,EPSG' );

-- Custom ellipsoids (from proj -le)

INSERT INTO "ellipsoid" VALUES('PROJ','ANDRAE','Andrae 1876 (Denmark, Iceland)',NULL,'PROJ','EARTH',6377104.43,'EPSG','9001',300.0,NULL,0);
INSERT INTO "ellipsoid" VALUES('PROJ','CPM','Comité international des poids et mesures 1799',NULL,'PROJ','EARTH',6375738.7,'EPSG','9001',334.29,NULL,0);
INSERT INTO "ellipsoid" VALUES('PROJ','DELMBR','Delambre 1810 (Belgium)',NULL,'PROJ','EARTH',6376428.0,'EPSG','9001',311.5,NULL,0);
INSERT INTO "ellipsoid" VALUES('PROJ','KAULA','Kaula 1961',NULL,'PROJ','EARTH',6378163.0,'EPSG','9001',298.24,NULL,0);
INSERT INTO "ellipsoid" VALUES('PROJ','LERCH','Lerch 1979',NULL,'PROJ','EARTH',6378139.0,'EPSG','9001',298.257,NULL,0);
INSERT INTO "ellipsoid" VALUES('PROJ','MERIT','MERIT 1983',NULL,'PROJ','EARTH',6378137.0,'EPSG','9001',298.257,NULL,0);
INSERT INTO "ellipsoid" VALUES('PROJ','MPRTS','Maupertius 1738',NULL,'PROJ','EARTH',6397300.0,'EPSG','9001',191.0,NULL,0);
INSERT INTO "ellipsoid" VALUES('PROJ','NEW_INTL','New International 1967',NULL,'PROJ','EARTH',6378157.5,'EPSG','9001',NULL,6356772.2,0);
INSERT INTO "ellipsoid" VALUES('PROJ','WGS60','WGS 60',NULL,'PROJ','EARTH',6378165.0,'EPSG','9001',298.3,NULL,0);

-- Extra ellipsoids from IAU2000 dictionary (see https://github.com/USGS-Astrogeology/GDAL_scripts/blob/master/OGC_IAU2000_WKT_v2/naifcodes_radii_m_wAsteroids_IAU2000.csv)

INSERT INTO "ellipsoid" VALUES('PROJ','EARTH2000','Earth2000',NULL,'PROJ','EARTH',6378140.0,'EPSG','9001',NULL,6356750.0,0);

-- Coordinate system ENh for ProjectedCRS 3D. Should be removed once EPSG has such a coordinate system
INSERT INTO "coordinate_system" VALUES('PROJ','ENh','Cartesian',3);
INSERT INTO "axis" VALUES('PROJ','1','Easting','E','east','PROJ','ENh',1,'EPSG','9001');
INSERT INTO "axis" VALUES('PROJ','2','Northing','N','north','PROJ','ENh',2,'EPSG','9001');
INSERT INTO "axis" VALUES('PROJ','3','Ellipsoidal height','h','up','PROJ','ENh',2,'EPSG','9001');

---- Preferred hub for geodetic datum -----

INSERT INTO "geodetic_datum_preferred_hub" VALUES('EPSG','1152','EPSG','6326'); -- WGS84 (G730) to WGS84
INSERT INTO "geodetic_datum_preferred_hub" VALUES('EPSG','1153','EPSG','6326'); -- WGS84 (G873) to WGS84
INSERT INTO "geodetic_datum_preferred_hub" VALUES('EPSG','1154','EPSG','6326'); -- WGS84 (G1150) to WGS84
INSERT INTO "geodetic_datum_preferred_hub" VALUES('EPSG','1155','EPSG','6326'); -- WGS84 (G1674) to WGS84
INSERT INTO "geodetic_datum_preferred_hub" VALUES('EPSG','1156','EPSG','6326'); -- WGS84 (G1762) to WGS84
INSERT INTO "geodetic_datum_preferred_hub" VALUES('EPSG','1166','EPSG','6326'); -- WGS84 (Transit) to WGS84

-- Consider all WGS84 related CRS are equivalent with an accuracy of 2m
INSERT INTO "helmert_transformation" VALUES('PROJ','WGS84_TO_WGS84_G730','WGS 84 to WGS 84 (G730)','','Accuracy 2m','EPSG','9603','Geocentric translations (geog2D domain)','EPSG','4326','EPSG','9053','EPSG','1262',2.0,0,0,0,'EPSG','9001',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',0);
INSERT INTO "helmert_transformation" VALUES('PROJ','WGS84_TO_WGS84_G873','WGS 84 to WGS 84 (G873)','','Accuracy 2m','EPSG','9603','Geocentric translations (geog2D domain)','EPSG','4326','EPSG','9054','EPSG','1262',2.0,0,0,0,'EPSG','9001',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',0);
INSERT INTO "helmert_transformation" VALUES('PROJ','WGS84_TO_WGS84_G1150','WGS 84 to WGS 84 (G1150)','','Accuracy 2m','EPSG','9603','Geocentric translations (geog2D domain)','EPSG','4326','EPSG','9055','EPSG','1262',2.0,0,0,0,'EPSG','9001',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',0);
INSERT INTO "helmert_transformation" VALUES('PROJ','WGS84_TO_WGS84_G1674','WGS 84 to WGS 84 (G1674)','','Accuracy 2m','EPSG','9603','Geocentric translations (geog2D domain)','EPSG','4326','EPSG','9056','EPSG','1262',2.0,0,0,0,'EPSG','9001',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',0);
INSERT INTO "helmert_transformation" VALUES('PROJ','WGS84_TO_WGS84_G1762','WGS 84 to WGS 84 (G1762)','','Accuracy 2m','EPSG','9603','Geocentric translations (geog2D domain)','EPSG','4326','EPSG','9057','EPSG','1262',2.0,0,0,0,'EPSG','9001',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',0);
INSERT INTO "helmert_transformation" VALUES('PROJ','WGS84_TO_WGS84_TRANSIT','WGS 84 to WGS 84 (Transit)','','Accuracy 2m','EPSG','9603','Geocentric translations (geog2D domain)','EPSG','4326','EPSG','8888','EPSG','1262',2.0,0,0,0,'EPSG','9001',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',0);

--- Remove a few supersessions ---

-- TODO: remove this once https://github.com/OSGeo/proj-datumgrid/issues/55 is dealt with
-- The following supersessions are for geoid2012, replaced by geoid2018
-- but we don't have geoid2018 yet as PROJ grids, so remove for now those
-- supersessions
-- INSERT INTO "supersession" VALUES('grid_transformation','EPSG','6326','grid_transformation','EPSG','9229','EPSG');
-- INSERT INTO "supersession" VALUES('grid_transformation','EPSG','7646','grid_transformation','EPSG','9230','EPSG');
-- INSERT INTO "supersession" VALUES('grid_transformation','EPSG','7647','grid_transformation','EPSG','9231','EPSG');
DELETE FROM supersession WHERE superseded_table_name = 'grid_transformation' AND superseded_auth_name = 'EPSG' AND superseded_code = '6326';
DELETE FROM supersession WHERE superseded_table_name = 'grid_transformation' AND superseded_auth_name = 'EPSG' AND superseded_code = '7646';
DELETE FROM supersession WHERE superseded_table_name = 'grid_transformation' AND superseded_auth_name = 'EPSG' AND superseded_code = '7647';
