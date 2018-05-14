/*
 Navicat Premium Data Transfer

 Source Server         : mysql@127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 50626
 Source Host           : 127.0.0.1:3306
 Source Schema         : e-zip

 Target Server Type    : MySQL
 Target Server Version : 50626
 File Encoding         : 65001

 Date: 27/04/2018 05:28:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bpm_diagrams
-- ----------------------------
DROP TABLE IF EXISTS `bpm_diagrams`;
CREATE TABLE `bpm_diagrams`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'activity',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cover` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `created_date` datetime(0) NULL DEFAULT NULL,
  `created_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 71 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of bpm_diagrams
-- ----------------------------
INSERT INTO `bpm_diagrams` VALUES (62, 'Graph.diagram.type.Activity', 'Proses Pendaftaran', 'proses-pendaftaran', 'Bisnis proses pendaftaran peserta', '3ece50c9c7b2abb594cf717830ccece3.jpg', '2018-01-24 06:55:32', NULL);
INSERT INTO `bpm_diagrams` VALUES (64, 'Graph.diagram.type.Activity', 'Proses LKH', 'proses-lkh', 'Bisnis proses LKH', '6bb9365756b8dc7346902d8260a365f0.jpg', '2018-01-25 04:03:32', NULL);
INSERT INTO `bpm_diagrams` VALUES (65, 'Graph.diagram.type.Activity', 'Proses SKP', 'proses-skp', 'Bisnis proses dokumen SKP', '6c60fcd0c4c6e5470fd7f4b10ac5e809.jpg', '2018-01-25 04:05:59', NULL);
INSERT INTO `bpm_diagrams` VALUES (68, 'Graph.diagram.type.Activity', 'Proses Absensi', 'proses-absensi', 'Bisnis proses absensi', '6fdc79cb365c8a21412243cf1c1db571.jpg', '2018-03-05 03:11:21', NULL);
INSERT INTO `bpm_diagrams` VALUES (69, 'Graph.diagram.type.Activity', 'PROSES SURAT KELUAR', 'proses-surat-keluar', 'Bisnis proses administrasi surat keluar', 'e72399ec2634fefdf5054daff7842e16.jpg', '2018-04-27 04:31:07', NULL);
INSERT INTO `bpm_diagrams` VALUES (70, 'Graph.diagram.type.Activity', 'PROSES SURAT MASUK', 'proses-surat-masuk', 'Bisnis proses administrasi surat masuk', '9e395bfaa176fe92af66831e01f5e4e0.jpg', '2018-04-27 04:49:55', NULL);

-- ----------------------------
-- Table structure for bpm_forms
-- ----------------------------
DROP TABLE IF EXISTS `bpm_forms`;
CREATE TABLE `bpm_forms`  (
  `bf_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bf_activity` bigint(20) NULL DEFAULT NULL,
  `bf_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `bf_description` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `bf_tpl_file` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `bf_tpl_orig` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`bf_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 82 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of bpm_forms
-- ----------------------------
INSERT INTO `bpm_forms` VALUES (12, 808, 'Site planning upload template', 'No description', '19d1f246a90d48307faeac3fdb31a30e.html', 'upload.html');
INSERT INTO `bpm_forms` VALUES (13, 809, 'Approval template', 'No description', '6f64be85304054dee25e47629da7c6d3.html', 'approval.html');
INSERT INTO `bpm_forms` VALUES (14, 813, 'Create SSR template', 'No description', 'fe6683b844815e3e1864772e20fab81c.html', 'create-site-ssr.html');
INSERT INTO `bpm_forms` VALUES (15, 821, 'Sent Data SSR template', 'No description', '73a72a7da1f948d2ae66541209894d24.html', 'send-data-ssr.html');
INSERT INTO `bpm_forms` VALUES (16, 819, 'Add far end template', 'No description', '6edbcdb933fae65132a71f658fb14038.html', 'add-far-end.html');
INSERT INTO `bpm_forms` VALUES (17, 817, 'Review far end template', 'No description', 'dbce59b50bb42ef7997246eea071a6f7.html', 'review-far-end.html');
INSERT INTO `bpm_forms` VALUES (18, 811, 'Update prodef template', 'No description', '6fb5ce6462d47296620683c9d779ce27.html', 'upload-prodef.html');
INSERT INTO `bpm_forms` VALUES (19, 825, 'Open Opportunity Form', 'No description', 'e870a901848a6d2859d15f04d6284630.html', 'oportunity_form_2.html');
INSERT INTO `bpm_forms` VALUES (40, 894, 'Form pendaftaran', 'No description', '75289f801d3be476f571c3d735b9ffb1.html', 'form-pendaftaran.html');
INSERT INTO `bpm_forms` VALUES (42, 895, 'Form Pendaftaran', 'Form untuk menginput data peserta', '5db627c0354400886a4dcd752a99c823.html', 'form-pendaftaran.html');
INSERT INTO `bpm_forms` VALUES (44, 896, 'Form Autentikasi', 'Form untuk melakukan autentikasi data peserta', 'a41fc516f4faf88f37ce51b2ec95b5dd.html', 'form-pendaftaran-auth.html');
INSERT INTO `bpm_forms` VALUES (46, 897, 'Form Konfirmasi', 'No description', '097a5f6abd079951b27ddddf39cb8d5d.html', 'form-pendaftaran-conf.html');
INSERT INTO `bpm_forms` VALUES (60, 899, 'View Terdaftar', 'Formulir tampilan data pendaftar (readonly)', 'eef09bee368cf668aef236c42f620bbe.html', 'form-pendaftaran-view.html');
INSERT INTO `bpm_forms` VALUES (65, 904, 'Form SKP', 'No description', '3987586ea5c5fe717ddf35d62cccc7df.html', 'form-skp.html');
INSERT INTO `bpm_forms` VALUES (66, 905, 'Form SKP', 'No description', 'a6cc78446b37fa88b1043eb4d8b16ecc.html', 'form-skp.html');
INSERT INTO `bpm_forms` VALUES (67, 947, 'Form Pemeriksaan', 'No description', '5cd1119d6b7e9a27a1f7d174943bd137.html', 'form-skp.html');
INSERT INTO `bpm_forms` VALUES (74, 950, 'Form Absensi', 'Form Absensi', 'dba8c69ff88fa3d712249d31eebf7500.html', 'form-absensi.html');
INSERT INTO `bpm_forms` VALUES (75, 951, 'Form Absensi', 'Form Absensi', '792b6d4ac3aae7cd621306805d0ac674.html', 'form-absensi.html');
INSERT INTO `bpm_forms` VALUES (76, 907, 'Form LKH', 'No description', 'e99c356d9b9ffa77c3d0a2aa3343e1b3.html', 'form-lkh.html');
INSERT INTO `bpm_forms` VALUES (77, 938, 'Form LKH', 'No description', '2ad57d60defd5cd0cfce5c84b2f4889a.html', 'form-lkh.html');
INSERT INTO `bpm_forms` VALUES (78, 939, 'Form LKH', 'No description', '5d3a8fe7d9129f8f6b788735a29fc410.html', 'form-lkh.html');
INSERT INTO `bpm_forms` VALUES (80, 957, 'Form Penerimaan', 'No description', 'bcb0c3bc1fb633c31a210175b98c3005.html', 'form-skp.html');
INSERT INTO `bpm_forms` VALUES (81, 954, 'Form Pengesahan', 'No description', '5f346a5dde84ddf6574126dda502ea54.html', 'form-lkh.html');

-- ----------------------------
-- Table structure for bpm_forms_roles
-- ----------------------------
DROP TABLE IF EXISTS `bpm_forms_roles`;
CREATE TABLE `bpm_forms_roles`  (
  `bfr_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bfr_bf_id` bigint(20) NULL DEFAULT NULL,
  `bfr_sr_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`bfr_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of bpm_forms_roles
-- ----------------------------
INSERT INTO `bpm_forms_roles` VALUES (9, 12, 1);
INSERT INTO `bpm_forms_roles` VALUES (10, 13, 1);

-- ----------------------------
-- Table structure for bpm_forms_users
-- ----------------------------
DROP TABLE IF EXISTS `bpm_forms_users`;
CREATE TABLE `bpm_forms_users`  (
  `bfu_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bfu_bf_id` bigint(20) NULL DEFAULT NULL,
  `bfu_su_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`bfu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of bpm_forms_users
-- ----------------------------
INSERT INTO `bpm_forms_users` VALUES (6, 12, 1);
INSERT INTO `bpm_forms_users` VALUES (8, 13, 1);
INSERT INTO `bpm_forms_users` VALUES (10, 14, 1);
INSERT INTO `bpm_forms_users` VALUES (12, 15, 1);
INSERT INTO `bpm_forms_users` VALUES (14, 16, 1);
INSERT INTO `bpm_forms_users` VALUES (16, 17, 1);
INSERT INTO `bpm_forms_users` VALUES (18, 18, 1);

-- ----------------------------
-- Table structure for bpm_links
-- ----------------------------
DROP TABLE IF EXISTS `bpm_links`;
CREATE TABLE `bpm_links`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `client_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `client_source` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `client_target` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `router_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `diagram_id` bigint(20) NULL DEFAULT NULL,
  `source_id` bigint(20) NULL DEFAULT NULL,
  `target_id` bigint(20) NULL DEFAULT NULL,
  `command` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `stroke` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `label` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `label_distance` double NULL DEFAULT NULL,
  `convex` int(11) NULL DEFAULT 1,
  `smooth` int(11) NULL DEFAULT 1,
  `smoothness` bigint(20) NULL DEFAULT NULL,
  `data_source` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `params` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 819 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of bpm_links
-- ----------------------------
INSERT INTO `bpm_links` VALUES (704, 'tahap-pendaftaran', 'graph-link-1', 'graph-shape-1', 'graph-shape-2', 'Graph.link.Orthogonal', 'orthogonal', 62, 894, 895, 'M611,96.21874999999967L611,179.21875000000014', '#000', 'Tahap Pendaftaran', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (705, 'tahap-autentifikasi', 'graph-link-2', 'graph-shape-2', 'graph-shape-3', 'Graph.link.Orthogonal', 'orthogonal', 62, 895, 896, 'M611,239.21875000000009L611,318.2187499999991', '#000', 'Tahap Autentifikasi', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (706, 'tahap-konfirmasi', 'graph-link-3', 'graph-shape-3', 'graph-shape-4', 'Graph.link.Orthogonal', 'orthogonal', 62, 896, 897, 'M611.0000000000063,378.2187500000007L611.000000000003,454.21874999999847', '#000', 'Tahap Konfirmasi', 0.5, 1, 0, 6, NULL, '[{\"field\":\"su_task_flag\",\"comparison\":\"=\",\"value\":\"CONFIRMATION\",\"operator\":\"\"}]');
INSERT INTO `bpm_links` VALUES (708, 'pegawai-terdaftar', 'graph-link-4', 'graph-shape-4', 'graph-shape-5', 'Graph.link.Orthogonal', 'orthogonal', 62, 897, 899, 'M611.0000000000051,514.218749999999L611.0000000000009,626.2187500000002', '#000', 'Pegawai Terdaftar', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (709, NULL, 'graph-link-5', 'graph-shape-5', 'graph-shape-6', 'Graph.link.Orthogonal', 'orthogonal', 62, 899, 900, 'M611.0000000000001,686.218749999998L611.0000000000001,765.2187500000005', '#000', '', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (712, 'tahap-pembuatan', 'graph-link-7', 'graph-shape-7', 'graph-shape-8', 'Graph.link.Orthogonal', 'orthogonal', 65, 904, 905, 'M593.0000000000086,79.21875000000001L593.0000000000008,161.21875000000026', '#000', 'Tahap Pembuatan', 0.5, 1, 0, 6, NULL, '[{\"field\":\"skp_task_flag\",\"comparison\":\"=\",\"value\":\"TODO\",\"operator\":\"\"}]');
INSERT INTO `bpm_links` VALUES (759, 'tahap-pemeriksaan', 'graph-link-7', 'graph-shape-9', 'graph-shape-10', 'Graph.link.Orthogonal', 'orthogonal', 64, 938, 939, 'M594.0000000000018,253.21875000000026L593.9999999999989,357.21875000000034', '#000', 'Tahap Pemeriksaan', 0.5, 1, 0, 6, NULL, '[{\"field\":\"lkh_flag\",\"comparison\":\"=\",\"value\":\"EXAM\",\"operator\":\"\"}]');
INSERT INTO `bpm_links` VALUES (770, 'tahap-penilaian', 'graph-link-8', 'graph-shape-8', 'graph-shape-10', 'Graph.link.Orthogonal', 'orthogonal', 65, 905, 947, 'M593.0000000000007,221.2187500000007L593.0000000000123,309.21874999999994', '#000', 'Tahap Penilaian', 0.5, 1, 0, 6, NULL, '[{\"field\":\"skp_task_flag\",\"comparison\":\"=\",\"value\":\"EXAM\",\"operator\":\"\"}]');
INSERT INTO `bpm_links` VALUES (780, 'tahap-pembuatan', 'graph-link-8', 'graph-shape-7', 'graph-shape-9', 'Graph.link.Orthogonal', 'orthogonal', 64, 907, 938, 'M594,95.21875000000044L593.9999999999993,193.21875000000006', '#000', 'Tahap Pembuatan', 0.5, 1, 0, 6, NULL, '[{\"field\":\"lkh_flag\",\"comparison\":\"=\",\"value\":\"TODO\",\"operator\":\"\"}]');
INSERT INTO `bpm_links` VALUES (781, 'tahap-absensi', 'graph-link-17', 'graph-shape-18', 'graph-shape-19', 'Graph.link.Orthogonal', 'orthogonal', 68, 950, 951, 'M568,124.21874999999939L568,204.21875000000017', '#000', 'Tahap Absensi', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (782, NULL, 'graph-link-18', 'graph-shape-19', 'graph-shape-20', 'Graph.link.Orthogonal', 'orthogonal', 68, 951, 952, 'M568.0000000000002,264.21874999999955L567.9999999999994,334.2187500000009', '#000', '', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (784, NULL, 'graph-link-9', 'graph-shape-11', 'graph-shape-8', 'Graph.link.Orthogonal', 'orthogonal', 64, 954, 909, 'M594,594.4053792823967L594,677.4053792823992', '#000', '', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (792, 'tahap-pengesahan', 'graph-link-10', 'graph-shape-10', 'graph-shape-11', 'Graph.link.Orthogonal', 'orthogonal', 64, 939, 954, 'M594.0000000000055,417.2187500000013L594.0000000000028,534.4053792824009', '#000', 'Tahap Pengesahan', 0.5, 1, 0, 6, NULL, '[{\"field\":\"lkh_flag\",\"comparison\":\"=\",\"value\":\"DONE\",\"operator\":\"\"}]');
INSERT INTO `bpm_links` VALUES (793, NULL, 'graph-link-9', 'graph-shape-11', 'graph-shape-9', 'Graph.link.Orthogonal', 'orthogonal', 65, 957, 906, 'M593.0000000000142,555.218749999998L592.9999999999914,670.7346863617497', '#000', '', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (795, 'tahap-pembuatan', 'graph-link-11', 'graph-shape-10', 'graph-shape-9', 'Graph.link.Orthogonal', 'orthogonal', 64, 939, 938, 'M524,387.2187499999745L370.99999999999693,387.21875L370.99999999999693,223.21875L524,223.2187500000119', '#000', 'Tahap Pembuatan', 0.5, 1, 0, 6, NULL, '[{\"field\":\"lkh_flag\",\"comparison\":\"=\",\"value\":\"TODO\",\"operator\":\"\"}]');
INSERT INTO `bpm_links` VALUES (796, 'tahap-pendaftaran', 'graph-link-6', 'graph-shape-3', 'graph-shape-2', 'Graph.link.Orthogonal', 'orthogonal', 62, 896, 895, 'M541,348.2187500000001L403,348.21875L403,209.21875L541,209.21875000000057', '#000', 'Tahap Pendaftaran', 0.5, 1, 0, 6, NULL, '[{\"field\":\"su_task_flag\",\"comparison\":\"=\",\"value\":\"REVISION\",\"operator\":\"\"}]');
INSERT INTO `bpm_links` VALUES (797, 'tahap-pembuatan', 'graph-link-10', 'graph-shape-10', 'graph-shape-8', 'Graph.link.Orthogonal', 'orthogonal', 65, 947, 905, 'M523.0000000000088,339.21874999999994L386.0000000000065,339.21875L386.0000000000065,191.21875L523,191.21874999999957', '#000', 'Tahap Pembuatan', 0.5, 1, 0, 6, NULL, '[{\"field\":\"skp_task_flag\",\"comparison\":\"=\",\"value\":\"REVISION\",\"operator\":\"\"}]');
INSERT INTO `bpm_links` VALUES (798, 'tahap-pengesahan', 'graph-link-11', 'graph-shape-10', 'graph-shape-11', 'Graph.link.Orthogonal', 'orthogonal', 65, 947, 957, 'M593.0000000000014,369.2187499999994L593.000000000011,495.21874999999915', '#000', 'Tahap Pengesahan', 0.5, 1, 0, 6, NULL, '[{\"field\":\"skp_task_flag\",\"comparison\":\"=\",\"value\":\"DONE\",\"operator\":\"\"}]');
INSERT INTO `bpm_links` VALUES (799, NULL, 'graph-link-1', 'graph-shape-1', 'graph-shape-2', 'Graph.link.Orthogonal', 'orthogonal', 69, 958, 959, 'M560.9999999999992,118.21875000000007L561.0000000000017,191.21875000000034', '#000', '', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (800, 'tahap-koreksi-e4', 'graph-link-2', 'graph-shape-2', 'graph-shape-3', 'Graph.link.Orthogonal', 'orthogonal', 69, 959, 960, 'M561.0000000000017,251.2187500000004L561.0000000000026,322.21875000000074', '#000', 'Tahap Koreksi E4', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (801, 'tahap-pembuatan', 'graph-link-13', 'graph-shape-3', 'graph-shape-2', 'Graph.link.Orthogonal', 'orthogonal', 69, 960, 959, 'M490.99999999999994,352.21875000000057L412.9999999999971,352.21875L412.9999999999971,235.21874999999994L491,235.21875000000023', '#000', 'Tahap Pembuatan', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (802, 'tahap-pembuatan', 'graph-link-14', 'graph-shape-4', 'graph-shape-2', 'Graph.link.Orthogonal', 'orthogonal', 69, 961, 959, 'M491.00000000000006,499.2187500000033L380.9999999999934,499.21875L380.9999999999934,221.21875L491,221.2187499999999', '#000', 'Tahap Pembuatan', 0.40160874054787, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (803, 'tahap-pembuatan', 'graph-link-15', 'graph-shape-5', 'graph-shape-2', 'Graph.link.Orthogonal', 'orthogonal', 69, 962, 959, 'M491,639.2187500000144L348.00000000000864,639.21875L348.00000000000864,206.21874999999997L491,206.2187499999994', '#000', 'Tahap Pembuatan', 0.30685156004814, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (804, 'tahap-koreksi-e3', 'graph-link-3', 'graph-shape-3', 'graph-shape-4', 'Graph.link.Orthogonal', 'orthogonal', 69, 960, 961, 'M561,382.2187499999988L560.9999999999999,469.21875000000125', '#000', 'Tahap Koreksi E3', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (805, 'tahap-koreksi-kapus', 'graph-link-4', 'graph-shape-4', 'graph-shape-5', 'Graph.link.Orthogonal', 'orthogonal', 69, 961, 962, 'M561,529.2187499999978L561,609.2187500000014', '#000', 'Tahap Koreksi Kapus', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (810, 'tahap-pengiriman', 'graph-link-22', 'graph-shape-3', 'graph-shape-10', 'Graph.link.Orthogonal', 'orthogonal', 69, 960, 966, 'M631,352.21874999999994L911,352.21875L910.9999999999985,469.21875000000085', '#000', 'Tahap Pengiriman', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (811, 'tahap-pengiriman', 'graph-link-23', 'graph-shape-4', 'graph-shape-10', 'Graph.link.Orthogonal', 'orthogonal', 69, 961, 966, 'M631,499.2187499999996L841,499.218750000008', '#000', 'Tahap Pengiriman', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (812, 'tahap-pengiriman', 'graph-link-24', 'graph-shape-5', 'graph-shape-10', 'Graph.link.Orthogonal', 'orthogonal', 69, 962, 966, 'M631,639.2187499999981L911,639.21875L910.999999999997,529.2187499999992', '#000', 'Tahap Pengiriman', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (813, NULL, 'graph-link-25', 'graph-shape-10', 'graph-shape-9', 'Graph.link.Orthogonal', 'orthogonal', 69, 966, 965, 'M981.0000000000001,499.21874999999807L1093.7582935622368,499.2187499999992', '#000', '', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (814, 'tahap-registrasi', 'graph-link-26', 'graph-shape-11', 'graph-shape-12', 'Graph.link.Orthogonal', 'orthogonal', 70, 967, 968, 'M566.9999999999997,100.21875000000021L567.0000000000011,161.2187500000001', '#000', 'Tahap Registrasi', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (815, 'tahap-baca', 'graph-link-27', 'graph-shape-12', 'graph-shape-13', 'Graph.link.Orthogonal', 'orthogonal', 70, 968, 969, 'M567,221.21874999999986L567,306.21875000000057', '#000', 'Tahap Baca', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (816, 'tahap-disposisi', 'graph-link-28', 'graph-shape-13', 'graph-shape-14', 'Graph.link.Orthogonal', 'orthogonal', 70, 969, 970, 'M566.9999999999983,366.2187500000003L567.0000000000032,456.21874999999994', '#000', 'Tahap Disposisi', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (817, 'tahap-balas', 'graph-link-29', 'graph-shape-14', 'graph-shape-15', 'Graph.link.Orthogonal', 'orthogonal', 70, 970, 971, 'M567.0000000000056,516.2187499999997L567.0000000000038,605.2187500000008', '#000', 'Tahap Balas', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (818, NULL, 'graph-link-30', 'graph-shape-15', 'graph-shape-16', 'Graph.link.Orthogonal', 'orthogonal', 70, 971, 972, 'M566.9999999999953,665.2187499999985L567.0000000000028,756.2187499999991', '#000', '', 0.5, 1, 0, 6, NULL, '[]');

-- ----------------------------
-- Table structure for bpm_shapes
-- ----------------------------
DROP TABLE IF EXISTS `bpm_shapes`;
CREATE TABLE `bpm_shapes`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `client_parent` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `client_pool` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `mode` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `diagram_id` bigint(20) NULL DEFAULT NULL,
  `parent_id` bigint(20) NULL DEFAULT NULL,
  `width` double NULL DEFAULT NULL,
  `height` double NULL DEFAULT NULL,
  `left` double NULL DEFAULT NULL,
  `top` double NULL DEFAULT NULL,
  `rotate` double NULL DEFAULT NULL,
  `label` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `fill` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `stroke` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `stroke_width` bigint(20) NULL DEFAULT NULL,
  `data_source` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `params` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 973 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of bpm_shapes
-- ----------------------------
INSERT INTO `bpm_shapes` VALUES (894, 'graph-shape-1', NULL, NULL, 'Graph.shape.activity.Start', NULL, 62, NULL, 60, 60, 581, 36.21875, 0, 'Start', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (895, 'graph-shape-2', NULL, NULL, 'Graph.shape.activity.Action', NULL, 62, NULL, 140, 60, 541, 179.21875, 0, 'Tahap Pendaftaran', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (896, 'graph-shape-3', NULL, NULL, 'Graph.shape.activity.Action', NULL, 62, NULL, 140, 60, 541, 318.21875, 0, 'Tahap Autentikasi', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (897, 'graph-shape-4', NULL, NULL, 'Graph.shape.activity.Action', NULL, 62, NULL, 140, 60, 541, 454.21875, 0, 'Tahap Konfirmasi', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (899, 'graph-shape-5', NULL, NULL, 'Graph.shape.activity.Action', NULL, 62, NULL, 140, 60, 541, 626.21875, 0, 'Pegawai Terdaftar', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (900, 'graph-shape-6', NULL, NULL, 'Graph.shape.activity.Final', NULL, 62, NULL, 60, 60, 581, 765.21875, 0, 'End', '#FF4081', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (904, 'graph-shape-7', NULL, NULL, 'Graph.shape.activity.Start', NULL, 65, NULL, 60, 60, 563.00000000001, 19.21875, 0, 'Start', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (905, 'graph-shape-8', NULL, NULL, 'Graph.shape.activity.Action', NULL, 65, NULL, 140, 60, 523, 161.21875, 0, 'Tahap Pembuatan', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (906, 'graph-shape-9', NULL, NULL, 'Graph.shape.activity.Final', NULL, 65, NULL, 60.179160620936, 60, 562.91041968954, 670.73468636175, 0, 'End', '#FF4081', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (907, 'graph-shape-7', NULL, NULL, 'Graph.shape.activity.Start', NULL, 64, NULL, 60, 60, 564, 35.21875, 0, 'Start', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (909, 'graph-shape-8', NULL, NULL, 'Graph.shape.activity.Final', NULL, 64, NULL, 60, 60, 564, 677.4053792824, 0, 'End', '#FF4081', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (938, 'graph-shape-9', NULL, NULL, 'Graph.shape.activity.Action', NULL, 64, NULL, 140, 60, 524, 193.21875, 0, 'Tahap Pembuatan', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (939, 'graph-shape-10', NULL, NULL, 'Graph.shape.activity.Action', NULL, 64, NULL, 140, 60, 524, 357.21875, 0, 'Tahap Pemeriksaan', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (947, 'graph-shape-10', NULL, NULL, 'Graph.shape.activity.Action', NULL, 65, NULL, 140, 60, 523.00000000001, 309.21875, 0, 'Tahap Penilaian', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (950, 'graph-shape-18', NULL, NULL, 'Graph.shape.activity.Start', NULL, 68, NULL, 60, 60, 538, 64.21875, 0, 'Start', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (951, 'graph-shape-19', NULL, NULL, 'Graph.shape.activity.Action', NULL, 68, NULL, 140, 60, 498, 204.21875, 0, 'Tahap Absensi', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (952, 'graph-shape-20', NULL, NULL, 'Graph.shape.activity.Final', NULL, 68, NULL, 60, 60, 538, 334.21875, 0, 'End', '#FF4081', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (954, 'graph-shape-11', NULL, NULL, 'Graph.shape.activity.Action', NULL, 64, NULL, 140, 60, 524, 534.4053792824, 0, 'Tahap Pengesahan', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (957, 'graph-shape-11', NULL, NULL, 'Graph.shape.activity.Action', NULL, 65, NULL, 140, 60, 523.00000000001, 495.21875, 0, 'Tahap Pengesahan', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (958, 'graph-shape-1', NULL, NULL, 'Graph.shape.activity.Start', NULL, 69, NULL, 60, 60, 531, 58.21875, 0, 'Start', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (959, 'graph-shape-2', NULL, NULL, 'Graph.shape.activity.Action', NULL, 69, NULL, 140, 60, 491, 191.21875, 0, 'Tahap Pembuatan', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (960, 'graph-shape-3', NULL, NULL, 'Graph.shape.activity.Action', NULL, 69, NULL, 140, 60, 491, 322.21875, 0, 'Tahap Koreksi E4', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (961, 'graph-shape-4', NULL, NULL, 'Graph.shape.activity.Action', NULL, 69, NULL, 140, 60, 491, 469.21875, 0, 'Tahap Koreksi E3', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (962, 'graph-shape-5', NULL, NULL, 'Graph.shape.activity.Action', NULL, 69, NULL, 140, 60, 491, 609.21875, 0, 'Tahap Koreksi Kapus', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (965, 'graph-shape-9', NULL, NULL, 'Graph.shape.activity.Final', NULL, 69, NULL, 60.089513538189, 60, 1093.3092397813, 469.21875, 0, 'End', '#FF4081', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (966, 'graph-shape-10', NULL, NULL, 'Graph.shape.activity.Action', NULL, 69, NULL, 140, 60, 841, 469.21875, 0, 'Tahap Pengiriman', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (967, 'graph-shape-11', NULL, NULL, 'Graph.shape.activity.Start', NULL, 70, NULL, 60, 60, 537, 40.21875, 0, 'Start', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (968, 'graph-shape-12', NULL, NULL, 'Graph.shape.activity.Action', NULL, 70, NULL, 140, 60, 497, 161.21875, 0, 'Tahap Registrasi', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (969, 'graph-shape-13', NULL, NULL, 'Graph.shape.activity.Action', NULL, 70, NULL, 140, 60, 497, 306.21875, 0, 'Tahap Baca', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (970, 'graph-shape-14', NULL, NULL, 'Graph.shape.activity.Action', NULL, 70, NULL, 140, 60, 497, 456.21875, 0, 'Tahap Disposisi', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (971, 'graph-shape-15', NULL, NULL, 'Graph.shape.activity.Action', NULL, 70, NULL, 140, 60, 497, 605.21875, 0, 'Tahap Balas', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (972, 'graph-shape-16', NULL, NULL, 'Graph.shape.activity.Final', NULL, 70, NULL, 60, 60, 537, 756.21875, 0, 'End', '#FF4081', 'rgb(0, 0, 0)', 2, NULL, '[]');

-- ----------------------------
-- Table structure for dx_auth
-- ----------------------------
DROP TABLE IF EXISTS `dx_auth`;
CREATE TABLE `dx_auth`  (
  `auth_col_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_child_id` bigint(20) NULL DEFAULT NULL,
  `map_id` bigint(20) NULL DEFAULT NULL,
  `dx_read` bigint(20) NULL DEFAULT NULL,
  `dx_write` bigint(20) NULL DEFAULT NULL,
  `dx_edit` bigint(20) NULL DEFAULT NULL,
  `dx_delete` bigint(20) NULL DEFAULT NULL,
  `dx_default` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`auth_col_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for dx_mapping
-- ----------------------------
DROP TABLE IF EXISTS `dx_mapping`;
CREATE TABLE `dx_mapping`  (
  `map_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `map_profile_id` bigint(20) NOT NULL,
  `map_table` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `map_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'data',
  `map_xls_col` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `map_tbl_col` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `map_dtype` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'string',
  `map_pk` bigint(20) NULL DEFAULT NULL,
  `map_mandatory` bigint(20) NULL DEFAULT NULL,
  `map_ref_table` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `map_ref_col` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `map_ref_fk` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `map_ref_ignore` bigint(20) NULL DEFAULT NULL,
  `map_active` bigint(20) NULL DEFAULT NULL,
  `map_col_alias` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `map_grp_seq` bigint(20) NULL DEFAULT NULL,
  `map_sk` bigint(20) NULL DEFAULT NULL,
  `map_ref_contents` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `map_col_seq` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`map_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of dx_mapping
-- ----------------------------
INSERT INTO `dx_mapping` VALUES (1, 1, 'example_1', 'data', 'EMAIL', 'email', 'string', 1, 0, NULL, NULL, NULL, 0, 1, NULL, 1, 0, NULL, NULL);
INSERT INTO `dx_mapping` VALUES (3, 1, 'example_1', 'data', 'DEBUG', 'debug', 'string', 0, 0, NULL, NULL, NULL, 0, 1, NULL, 1, 0, NULL, NULL);
INSERT INTO `dx_mapping` VALUES (4, 1, 'example_1', 'data', 'SEX', 'sex', 'int', 0, 0, NULL, NULL, NULL, 0, 1, NULL, 1, 0, NULL, NULL);
INSERT INTO `dx_mapping` VALUES (5, 1, 'example_2', 'data', 'USERNAME', 'username', 'string', 1, 0, NULL, NULL, NULL, 0, 0, NULL, 1, 0, NULL, NULL);
INSERT INTO `dx_mapping` VALUES (6, 1, 'example_1', 'data', 'DOB', 'dob', 'date', 0, 0, NULL, NULL, NULL, 0, 1, NULL, 1, 0, NULL, NULL);
INSERT INTO `dx_mapping` VALUES (7, 1, 'example_1', 'data', 'AVATAR', 'avatar', 'string', 0, 0, NULL, NULL, NULL, 0, 1, NULL, 1, 0, NULL, NULL);
INSERT INTO `dx_mapping` VALUES (8, 1, 'example_1', 'data', 'POINTS', 'points', 'double', 0, 0, NULL, NULL, NULL, 0, 1, NULL, 1, 0, NULL, NULL);
INSERT INTO `dx_mapping` VALUES (9, 1, 'example_1', 'data', 'FULLNAME', 'fullname', 'string', 0, 0, NULL, NULL, NULL, 0, 1, NULL, 1, 0, NULL, NULL);
INSERT INTO `dx_mapping` VALUES (10, 4, 'A', 'data', '1', 'A', 'A', 1, 0, NULL, NULL, NULL, 0, 1, NULL, NULL, 1, NULL, NULL);

-- ----------------------------
-- Table structure for dx_profiles
-- ----------------------------
DROP TABLE IF EXISTS `dx_profiles`;
CREATE TABLE `dx_profiles`  (
  `profile_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `profile_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `profile_desc` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `header_row_idx` bigint(20) NULL DEFAULT NULL,
  `col_offset` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `row_offset` bigint(20) NULL DEFAULT NULL,
  `map_header` bigint(20) NULL DEFAULT NULL,
  `has_merge_cell` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`profile_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of dx_profiles
-- ----------------------------
INSERT INTO `dx_profiles` VALUES (1, 'Example Profile', 'Example profile', 1, 'B', 2, 1, NULL);
INSERT INTO `dx_profiles` VALUES (4, 'foo', NULL, 1, 'A', 2, 1, NULL);
INSERT INTO `dx_profiles` VALUES (5, 'bar', NULL, 1, 'A', 1, 1, NULL);

-- ----------------------------
-- Table structure for kanban
-- ----------------------------
DROP TABLE IF EXISTS `kanban`;
CREATE TABLE `kanban`  (
  `panel_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `panel_color` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `panel_card_filter` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `panel_title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`panel_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of kanban
-- ----------------------------
INSERT INTO `kanban` VALUES (1, 'pink', 'isCardFilterTodo', 'To Do');
INSERT INTO `kanban` VALUES (2, 'blue', 'isCardFilterDoing', 'Doing');
INSERT INTO `kanban` VALUES (3, 'green', 'isCardFilterDone', 'Done');

-- ----------------------------
-- Table structure for kanban_forms
-- ----------------------------
DROP TABLE IF EXISTS `kanban_forms`;
CREATE TABLE `kanban_forms`  (
  `kf_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kf_diagrams_id` bigint(20) NULL DEFAULT NULL,
  `kf_status` bigint(20) NULL DEFAULT NULL,
  `kf_form_edit` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `kf_form_view` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kf_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of kanban_forms
-- ----------------------------
INSERT INTO `kanban_forms` VALUES (1, 49, 396, '', '');
INSERT INTO `kanban_forms` VALUES (2, 49, 397, '', '');
INSERT INTO `kanban_forms` VALUES (3, 49, 397, 'Capture.JPG', '');
INSERT INTO `kanban_forms` VALUES (4, 28, 96, '', '');
INSERT INTO `kanban_forms` VALUES (5, 28, 97, '', '');
INSERT INTO `kanban_forms` VALUES (6, 28, 98, '', '');
INSERT INTO `kanban_forms` VALUES (7, 28, 99, '', '');
INSERT INTO `kanban_forms` VALUES (8, 28, 105, '', '');

-- ----------------------------
-- Table structure for kanban_panels
-- ----------------------------
DROP TABLE IF EXISTS `kanban_panels`;
CREATE TABLE `kanban_panels`  (
  `kp_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kp_ks_id` bigint(20) NULL DEFAULT NULL,
  `kp_title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `kp_accent` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `kp_order` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`kp_id`) USING BTREE,
  INDEX `kp_idx_0`(`kp_ks_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 126 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of kanban_panels
-- ----------------------------
INSERT INTO `kanban_panels` VALUES (88, 24, 'Tahap Pendaftaran', '#2196f3', 0);
INSERT INTO `kanban_panels` VALUES (89, 24, 'Tahap Autentifikasi', '#607d8b', 1);
INSERT INTO `kanban_panels` VALUES (90, 24, 'Tahap Konfirmasi', '#e91e63', 2);
INSERT INTO `kanban_panels` VALUES (91, 24, 'Pegawai Terdaftar', '#4caf50', 3);
INSERT INTO `kanban_panels` VALUES (92, 25, 'Pembuatan', '#2196f3', 0);
INSERT INTO `kanban_panels` VALUES (93, 25, 'Penilaian', '#e91e63', 1);
INSERT INTO `kanban_panels` VALUES (101, 26, 'Pembuatan', '#9c27b0', 0);
INSERT INTO `kanban_panels` VALUES (102, 26, 'Pemeriksaan', '#e91e63', 1);
INSERT INTO `kanban_panels` VALUES (116, 30, 'Absensi', '#2196f3', 0);
INSERT INTO `kanban_panels` VALUES (118, 25, 'Pengesahan', '#4caf50', 2);
INSERT INTO `kanban_panels` VALUES (120, 26, 'Pengesahan', '#009688', 2);
INSERT INTO `kanban_panels` VALUES (122, 31, 'Tahap Registrasi', '#e91e63', 0);
INSERT INTO `kanban_panels` VALUES (123, 31, 'Tahap Baca', '#3f51b5', 1);
INSERT INTO `kanban_panels` VALUES (124, 31, 'Tahap Disposisi', '#2196f3', 2);
INSERT INTO `kanban_panels` VALUES (125, 31, 'Tahap Balas', '#4caf50', 3);

-- ----------------------------
-- Table structure for kanban_settings
-- ----------------------------
DROP TABLE IF EXISTS `kanban_settings`;
CREATE TABLE `kanban_settings`  (
  `ks_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ks_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ks_description` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ks_api` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ks_module` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ks_image` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ks_purpose` int(1) NULL DEFAULT 0,
  PRIMARY KEY (`ks_id`) USING BTREE,
  INDEX `ks_idx_0`(`ks_module`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of kanban_settings
-- ----------------------------
INSERT INTO `kanban_settings` VALUES (24, 'Template Pendaftaran', 'Template module pendafaran', NULL, 'pendaftaran', NULL, 0);
INSERT INTO `kanban_settings` VALUES (25, 'Template SKP', 'Template module SKP Tahunan', NULL, 'skp', NULL, 0);
INSERT INTO `kanban_settings` VALUES (26, 'Template LKH', 'Template module LKH', NULL, 'lkh', NULL, 0);
INSERT INTO `kanban_settings` VALUES (30, 'Template Absensi', 'Template module absensi', NULL, 'absensi', NULL, 0);
INSERT INTO `kanban_settings` VALUES (31, 'Template Surat Masuk', 'Template Surat Masuk', NULL, 'surat-masuk', NULL, 0);

-- ----------------------------
-- Table structure for kanban_statuses
-- ----------------------------
DROP TABLE IF EXISTS `kanban_statuses`;
CREATE TABLE `kanban_statuses`  (
  `kst_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kst_kp_id` bigint(20) NULL DEFAULT NULL,
  `kst_diagrams_id` bigint(20) NULL DEFAULT NULL,
  `kst_status` bigint(20) NULL DEFAULT NULL,
  `kst_color` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kst_id`) USING BTREE,
  INDEX `kp_idx_0`(`kst_kp_id`) USING BTREE,
  INDEX `kp_idx_1`(`kst_status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 151 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of kanban_statuses
-- ----------------------------
INSERT INTO `kanban_statuses` VALUES (98, 88, 62, 704, '#000');
INSERT INTO `kanban_statuses` VALUES (99, 89, 62, 705, '#000');
INSERT INTO `kanban_statuses` VALUES (100, 90, 62, 706, '#000');
INSERT INTO `kanban_statuses` VALUES (101, 91, 62, 708, '#000');
INSERT INTO `kanban_statuses` VALUES (104, 92, 65, 712, '#000');
INSERT INTO `kanban_statuses` VALUES (124, 102, 64, 759, '#000');
INSERT INTO `kanban_statuses` VALUES (129, 93, 65, 770, '#000');
INSERT INTO `kanban_statuses` VALUES (132, 101, 64, 780, '#000');
INSERT INTO `kanban_statuses` VALUES (133, 116, 68, 781, '#000');
INSERT INTO `kanban_statuses` VALUES (141, 120, 64, 792, '#000');
INSERT INTO `kanban_statuses` VALUES (143, 101, 64, 795, '#000');
INSERT INTO `kanban_statuses` VALUES (144, 88, 62, 796, '#000');
INSERT INTO `kanban_statuses` VALUES (145, 92, 65, 797, '#000');
INSERT INTO `kanban_statuses` VALUES (146, 118, 65, 798, '#000');
INSERT INTO `kanban_statuses` VALUES (147, 122, 70, 814, '#000');
INSERT INTO `kanban_statuses` VALUES (148, 123, 70, 815, '#000');
INSERT INTO `kanban_statuses` VALUES (149, 124, 70, 816, '#000');
INSERT INTO `kanban_statuses` VALUES (150, 125, 70, 817, '#000');

-- ----------------------------
-- Table structure for mst_customers
-- ----------------------------
DROP TABLE IF EXISTS `mst_customers`;
CREATE TABLE `mst_customers`  (
  `mc_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mc_company_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `mc_contact_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `mc_phone` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `mc_email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`mc_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of mst_customers
-- ----------------------------
INSERT INTO `mst_customers` VALUES (1, 'Pertamina', 'John Doe', '(021) 1234567', 'sales@company.com');
INSERT INTO `mst_customers` VALUES (2, 'Indofood', 'John Doe', '(021) 1234567', 'sales@company.com');
INSERT INTO `mst_customers` VALUES (3, 'XL Axiata', 'John Doe', '(021) 1234567', 'sales@company.com');
INSERT INTO `mst_customers` VALUES (4, 'Indosat', 'John Doe', '(021) 1234567', 'sales@company.com');
INSERT INTO `mst_customers` VALUES (5, 'Telkomsel', 'John Doe', '(021) 1234567', 'sales@company.com');
INSERT INTO `mst_customers` VALUES (6, 'Sampoerna', 'John Doe', '(021) 1234567', 'sales@company.com');
INSERT INTO `mst_customers` VALUES (7, 'Net Mediatama', 'John Doe', '(021) 1234567', 'sales@company.com');
INSERT INTO `mst_customers` VALUES (8, 'Rajawali Citra', 'John Doe', '(021) 1234567', 'sales@company.com');
INSERT INTO `mst_customers` VALUES (9, 'Trans Media', 'John Doe', '(021) 1234567', 'sales@company.com');
INSERT INTO `mst_customers` VALUES (11, 'Sinar Mas', 'John Doe', '(021) 1234567', 'sales@company.com');
INSERT INTO `mst_customers` VALUES (12, 'PT KCT', 'Said', '0818990199', 'said@kct.co.id');

-- ----------------------------
-- Table structure for sys_activities
-- ----------------------------
DROP TABLE IF EXISTS `sys_activities`;
CREATE TABLE `sys_activities`  (
  `ta_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ta_sp_id` int(11) NULL DEFAULT NULL,
  `ta_task_ns` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ta_task_id` bigint(20) NULL DEFAULT NULL,
  `ta_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ta_sender` bigint(20) NULL DEFAULT NULL,
  `ta_created` datetime(0) NULL DEFAULT NULL,
  `ta_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ta_data` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ta_subs` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ta_unreads` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`ta_id`) USING BTREE,
  INDEX `sa_idx_0`(`ta_task_ns`, `ta_task_id`, `ta_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sys_behaviors
-- ----------------------------
DROP TABLE IF EXISTS `sys_behaviors`;
CREATE TABLE `sys_behaviors`  (
  `tbh_id` int(11) NOT NULL AUTO_INCREMENT,
  `tbh_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tbh_mandatory` int(1) NULL DEFAULT 1,
  PRIMARY KEY (`tbh_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_behaviors
-- ----------------------------
INSERT INTO `sys_behaviors` VALUES (1, 'Orientasi Pelayanan', 1);
INSERT INTO `sys_behaviors` VALUES (2, 'Integritas', 1);
INSERT INTO `sys_behaviors` VALUES (3, 'Komitmen', 1);
INSERT INTO `sys_behaviors` VALUES (4, 'Disiplin', 1);
INSERT INTO `sys_behaviors` VALUES (5, 'Kerjasama', 1);
INSERT INTO `sys_behaviors` VALUES (6, 'Kepemimpinan', 0);

-- ----------------------------
-- Table structure for sys_calendar
-- ----------------------------
DROP TABLE IF EXISTS `sys_calendar`;
CREATE TABLE `sys_calendar`  (
  `sdt_id` int(11) NOT NULL AUTO_INCREMENT,
  `sdt_date` date NULL DEFAULT NULL,
  `sdt_group` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sdt_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 397 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_calendar
-- ----------------------------
INSERT INTO `sys_calendar` VALUES (1, '2018-01-01', '2018-01');
INSERT INTO `sys_calendar` VALUES (2, '2018-01-02', '2018-01');
INSERT INTO `sys_calendar` VALUES (3, '2018-01-03', '2018-01');
INSERT INTO `sys_calendar` VALUES (4, '2018-01-04', '2018-01');
INSERT INTO `sys_calendar` VALUES (5, '2018-01-05', '2018-01');
INSERT INTO `sys_calendar` VALUES (6, '2018-01-06', '2018-01');
INSERT INTO `sys_calendar` VALUES (7, '2018-01-07', '2018-01');
INSERT INTO `sys_calendar` VALUES (8, '2018-01-08', '2018-01');
INSERT INTO `sys_calendar` VALUES (9, '2018-01-09', '2018-01');
INSERT INTO `sys_calendar` VALUES (10, '2018-01-10', '2018-01');
INSERT INTO `sys_calendar` VALUES (11, '2018-01-11', '2018-01');
INSERT INTO `sys_calendar` VALUES (12, '2018-01-12', '2018-01');
INSERT INTO `sys_calendar` VALUES (13, '2018-01-13', '2018-01');
INSERT INTO `sys_calendar` VALUES (14, '2018-01-14', '2018-01');
INSERT INTO `sys_calendar` VALUES (15, '2018-01-15', '2018-01');
INSERT INTO `sys_calendar` VALUES (16, '2018-01-16', '2018-01');
INSERT INTO `sys_calendar` VALUES (17, '2018-01-17', '2018-01');
INSERT INTO `sys_calendar` VALUES (18, '2018-01-18', '2018-01');
INSERT INTO `sys_calendar` VALUES (19, '2018-01-19', '2018-01');
INSERT INTO `sys_calendar` VALUES (20, '2018-01-20', '2018-01');
INSERT INTO `sys_calendar` VALUES (21, '2018-01-21', '2018-01');
INSERT INTO `sys_calendar` VALUES (22, '2018-01-22', '2018-01');
INSERT INTO `sys_calendar` VALUES (23, '2018-01-23', '2018-01');
INSERT INTO `sys_calendar` VALUES (24, '2018-01-24', '2018-01');
INSERT INTO `sys_calendar` VALUES (25, '2018-01-25', '2018-01');
INSERT INTO `sys_calendar` VALUES (26, '2018-01-26', '2018-01');
INSERT INTO `sys_calendar` VALUES (27, '2018-01-27', '2018-01');
INSERT INTO `sys_calendar` VALUES (28, '2018-01-28', '2018-01');
INSERT INTO `sys_calendar` VALUES (29, '2018-01-29', '2018-01');
INSERT INTO `sys_calendar` VALUES (30, '2018-01-30', '2018-01');
INSERT INTO `sys_calendar` VALUES (31, '2018-01-31', '2018-01');
INSERT INTO `sys_calendar` VALUES (32, '2018-02-01', '2018-02');
INSERT INTO `sys_calendar` VALUES (33, '2018-02-02', '2018-02');
INSERT INTO `sys_calendar` VALUES (34, '2018-02-03', '2018-02');
INSERT INTO `sys_calendar` VALUES (35, '2018-02-04', '2018-02');
INSERT INTO `sys_calendar` VALUES (36, '2018-02-05', '2018-02');
INSERT INTO `sys_calendar` VALUES (37, '2018-02-06', '2018-02');
INSERT INTO `sys_calendar` VALUES (38, '2018-02-07', '2018-02');
INSERT INTO `sys_calendar` VALUES (39, '2018-02-08', '2018-02');
INSERT INTO `sys_calendar` VALUES (40, '2018-02-09', '2018-02');
INSERT INTO `sys_calendar` VALUES (41, '2018-02-10', '2018-02');
INSERT INTO `sys_calendar` VALUES (42, '2018-02-11', '2018-02');
INSERT INTO `sys_calendar` VALUES (43, '2018-02-12', '2018-02');
INSERT INTO `sys_calendar` VALUES (44, '2018-02-13', '2018-02');
INSERT INTO `sys_calendar` VALUES (45, '2018-02-14', '2018-02');
INSERT INTO `sys_calendar` VALUES (46, '2018-02-15', '2018-02');
INSERT INTO `sys_calendar` VALUES (47, '2018-02-16', '2018-02');
INSERT INTO `sys_calendar` VALUES (48, '2018-02-17', '2018-02');
INSERT INTO `sys_calendar` VALUES (49, '2018-02-18', '2018-02');
INSERT INTO `sys_calendar` VALUES (50, '2018-02-19', '2018-02');
INSERT INTO `sys_calendar` VALUES (51, '2018-02-20', '2018-02');
INSERT INTO `sys_calendar` VALUES (52, '2018-02-21', '2018-02');
INSERT INTO `sys_calendar` VALUES (53, '2018-02-22', '2018-02');
INSERT INTO `sys_calendar` VALUES (54, '2018-02-23', '2018-02');
INSERT INTO `sys_calendar` VALUES (55, '2018-02-24', '2018-02');
INSERT INTO `sys_calendar` VALUES (56, '2018-02-25', '2018-02');
INSERT INTO `sys_calendar` VALUES (57, '2018-02-26', '2018-02');
INSERT INTO `sys_calendar` VALUES (58, '2018-02-27', '2018-02');
INSERT INTO `sys_calendar` VALUES (59, '2018-02-28', '2018-02');
INSERT INTO `sys_calendar` VALUES (60, '2018-03-01', '2018-03');
INSERT INTO `sys_calendar` VALUES (61, '2018-03-02', '2018-03');
INSERT INTO `sys_calendar` VALUES (62, '2018-03-03', '2018-03');
INSERT INTO `sys_calendar` VALUES (63, '2018-03-04', '2018-03');
INSERT INTO `sys_calendar` VALUES (64, '2018-03-05', '2018-03');
INSERT INTO `sys_calendar` VALUES (65, '2018-03-06', '2018-03');
INSERT INTO `sys_calendar` VALUES (66, '2018-03-07', '2018-03');
INSERT INTO `sys_calendar` VALUES (67, '2018-03-08', '2018-03');
INSERT INTO `sys_calendar` VALUES (68, '2018-03-09', '2018-03');
INSERT INTO `sys_calendar` VALUES (69, '2018-03-10', '2018-03');
INSERT INTO `sys_calendar` VALUES (70, '2018-03-11', '2018-03');
INSERT INTO `sys_calendar` VALUES (71, '2018-03-12', '2018-03');
INSERT INTO `sys_calendar` VALUES (72, '2018-03-13', '2018-03');
INSERT INTO `sys_calendar` VALUES (73, '2018-03-14', '2018-03');
INSERT INTO `sys_calendar` VALUES (74, '2018-03-15', '2018-03');
INSERT INTO `sys_calendar` VALUES (75, '2018-03-16', '2018-03');
INSERT INTO `sys_calendar` VALUES (76, '2018-03-17', '2018-03');
INSERT INTO `sys_calendar` VALUES (77, '2018-03-18', '2018-03');
INSERT INTO `sys_calendar` VALUES (78, '2018-03-19', '2018-03');
INSERT INTO `sys_calendar` VALUES (79, '2018-03-20', '2018-03');
INSERT INTO `sys_calendar` VALUES (80, '2018-03-21', '2018-03');
INSERT INTO `sys_calendar` VALUES (81, '2018-03-22', '2018-03');
INSERT INTO `sys_calendar` VALUES (82, '2018-03-23', '2018-03');
INSERT INTO `sys_calendar` VALUES (83, '2018-03-24', '2018-03');
INSERT INTO `sys_calendar` VALUES (84, '2018-03-25', '2018-03');
INSERT INTO `sys_calendar` VALUES (85, '2018-03-26', '2018-03');
INSERT INTO `sys_calendar` VALUES (86, '2018-03-27', '2018-03');
INSERT INTO `sys_calendar` VALUES (87, '2018-03-28', '2018-03');
INSERT INTO `sys_calendar` VALUES (88, '2018-03-29', '2018-03');
INSERT INTO `sys_calendar` VALUES (89, '2018-03-30', '2018-03');
INSERT INTO `sys_calendar` VALUES (90, '2018-03-31', '2018-03');
INSERT INTO `sys_calendar` VALUES (91, '2018-04-01', '2018-04');
INSERT INTO `sys_calendar` VALUES (92, '2018-04-02', '2018-04');
INSERT INTO `sys_calendar` VALUES (93, '2018-04-03', '2018-04');
INSERT INTO `sys_calendar` VALUES (94, '2018-04-04', '2018-04');
INSERT INTO `sys_calendar` VALUES (95, '2018-04-05', '2018-04');
INSERT INTO `sys_calendar` VALUES (96, '2018-04-06', '2018-04');
INSERT INTO `sys_calendar` VALUES (97, '2018-04-07', '2018-04');
INSERT INTO `sys_calendar` VALUES (98, '2018-04-08', '2018-04');
INSERT INTO `sys_calendar` VALUES (99, '2018-04-09', '2018-04');
INSERT INTO `sys_calendar` VALUES (100, '2018-04-10', '2018-04');
INSERT INTO `sys_calendar` VALUES (101, '2018-04-11', '2018-04');
INSERT INTO `sys_calendar` VALUES (102, '2018-04-12', '2018-04');
INSERT INTO `sys_calendar` VALUES (103, '2018-04-13', '2018-04');
INSERT INTO `sys_calendar` VALUES (104, '2018-04-14', '2018-04');
INSERT INTO `sys_calendar` VALUES (105, '2018-04-15', '2018-04');
INSERT INTO `sys_calendar` VALUES (106, '2018-04-16', '2018-04');
INSERT INTO `sys_calendar` VALUES (107, '2018-04-17', '2018-04');
INSERT INTO `sys_calendar` VALUES (108, '2018-04-18', '2018-04');
INSERT INTO `sys_calendar` VALUES (109, '2018-04-19', '2018-04');
INSERT INTO `sys_calendar` VALUES (110, '2018-04-20', '2018-04');
INSERT INTO `sys_calendar` VALUES (111, '2018-04-21', '2018-04');
INSERT INTO `sys_calendar` VALUES (112, '2018-04-22', '2018-04');
INSERT INTO `sys_calendar` VALUES (113, '2018-04-23', '2018-04');
INSERT INTO `sys_calendar` VALUES (114, '2018-04-24', '2018-04');
INSERT INTO `sys_calendar` VALUES (115, '2018-04-25', '2018-04');
INSERT INTO `sys_calendar` VALUES (116, '2018-04-26', '2018-04');
INSERT INTO `sys_calendar` VALUES (117, '2018-04-27', '2018-04');
INSERT INTO `sys_calendar` VALUES (118, '2018-04-28', '2018-04');
INSERT INTO `sys_calendar` VALUES (119, '2018-04-29', '2018-04');
INSERT INTO `sys_calendar` VALUES (120, '2018-04-30', '2018-04');
INSERT INTO `sys_calendar` VALUES (121, '2018-05-01', '2018-05');
INSERT INTO `sys_calendar` VALUES (122, '2018-05-02', '2018-05');
INSERT INTO `sys_calendar` VALUES (123, '2018-05-03', '2018-05');
INSERT INTO `sys_calendar` VALUES (124, '2018-05-04', '2018-05');
INSERT INTO `sys_calendar` VALUES (125, '2018-05-05', '2018-05');
INSERT INTO `sys_calendar` VALUES (126, '2018-05-06', '2018-05');
INSERT INTO `sys_calendar` VALUES (127, '2018-05-07', '2018-05');
INSERT INTO `sys_calendar` VALUES (128, '2018-05-08', '2018-05');
INSERT INTO `sys_calendar` VALUES (129, '2018-05-09', '2018-05');
INSERT INTO `sys_calendar` VALUES (130, '2018-05-10', '2018-05');
INSERT INTO `sys_calendar` VALUES (131, '2018-05-11', '2018-05');
INSERT INTO `sys_calendar` VALUES (132, '2018-05-12', '2018-05');
INSERT INTO `sys_calendar` VALUES (133, '2018-05-13', '2018-05');
INSERT INTO `sys_calendar` VALUES (134, '2018-05-14', '2018-05');
INSERT INTO `sys_calendar` VALUES (135, '2018-05-15', '2018-05');
INSERT INTO `sys_calendar` VALUES (136, '2018-05-16', '2018-05');
INSERT INTO `sys_calendar` VALUES (137, '2018-05-17', '2018-05');
INSERT INTO `sys_calendar` VALUES (138, '2018-05-18', '2018-05');
INSERT INTO `sys_calendar` VALUES (139, '2018-05-19', '2018-05');
INSERT INTO `sys_calendar` VALUES (140, '2018-05-20', '2018-05');
INSERT INTO `sys_calendar` VALUES (141, '2018-05-21', '2018-05');
INSERT INTO `sys_calendar` VALUES (142, '2018-05-22', '2018-05');
INSERT INTO `sys_calendar` VALUES (143, '2018-05-23', '2018-05');
INSERT INTO `sys_calendar` VALUES (144, '2018-05-24', '2018-05');
INSERT INTO `sys_calendar` VALUES (145, '2018-05-25', '2018-05');
INSERT INTO `sys_calendar` VALUES (146, '2018-05-26', '2018-05');
INSERT INTO `sys_calendar` VALUES (147, '2018-05-27', '2018-05');
INSERT INTO `sys_calendar` VALUES (148, '2018-05-28', '2018-05');
INSERT INTO `sys_calendar` VALUES (149, '2018-05-29', '2018-05');
INSERT INTO `sys_calendar` VALUES (150, '2018-05-30', '2018-05');
INSERT INTO `sys_calendar` VALUES (151, '2018-05-31', '2018-05');
INSERT INTO `sys_calendar` VALUES (152, '2018-06-01', '2018-06');
INSERT INTO `sys_calendar` VALUES (153, '2018-06-02', '2018-06');
INSERT INTO `sys_calendar` VALUES (154, '2018-06-03', '2018-06');
INSERT INTO `sys_calendar` VALUES (155, '2018-06-04', '2018-06');
INSERT INTO `sys_calendar` VALUES (156, '2018-06-05', '2018-06');
INSERT INTO `sys_calendar` VALUES (157, '2018-06-06', '2018-06');
INSERT INTO `sys_calendar` VALUES (158, '2018-06-07', '2018-06');
INSERT INTO `sys_calendar` VALUES (159, '2018-06-08', '2018-06');
INSERT INTO `sys_calendar` VALUES (160, '2018-06-09', '2018-06');
INSERT INTO `sys_calendar` VALUES (161, '2018-06-10', '2018-06');
INSERT INTO `sys_calendar` VALUES (162, '2018-06-11', '2018-06');
INSERT INTO `sys_calendar` VALUES (163, '2018-06-12', '2018-06');
INSERT INTO `sys_calendar` VALUES (164, '2018-06-13', '2018-06');
INSERT INTO `sys_calendar` VALUES (165, '2018-06-14', '2018-06');
INSERT INTO `sys_calendar` VALUES (166, '2018-06-15', '2018-06');
INSERT INTO `sys_calendar` VALUES (167, '2018-06-16', '2018-06');
INSERT INTO `sys_calendar` VALUES (168, '2018-06-17', '2018-06');
INSERT INTO `sys_calendar` VALUES (169, '2018-06-18', '2018-06');
INSERT INTO `sys_calendar` VALUES (170, '2018-06-19', '2018-06');
INSERT INTO `sys_calendar` VALUES (171, '2018-06-20', '2018-06');
INSERT INTO `sys_calendar` VALUES (172, '2018-06-21', '2018-06');
INSERT INTO `sys_calendar` VALUES (173, '2018-06-22', '2018-06');
INSERT INTO `sys_calendar` VALUES (174, '2018-06-23', '2018-06');
INSERT INTO `sys_calendar` VALUES (175, '2018-06-24', '2018-06');
INSERT INTO `sys_calendar` VALUES (176, '2018-06-25', '2018-06');
INSERT INTO `sys_calendar` VALUES (177, '2018-06-26', '2018-06');
INSERT INTO `sys_calendar` VALUES (178, '2018-06-27', '2018-06');
INSERT INTO `sys_calendar` VALUES (179, '2018-06-28', '2018-06');
INSERT INTO `sys_calendar` VALUES (180, '2018-06-29', '2018-06');
INSERT INTO `sys_calendar` VALUES (181, '2018-06-30', '2018-06');
INSERT INTO `sys_calendar` VALUES (182, '2018-07-01', '2018-07');
INSERT INTO `sys_calendar` VALUES (183, '2018-07-02', '2018-07');
INSERT INTO `sys_calendar` VALUES (184, '2018-07-03', '2018-07');
INSERT INTO `sys_calendar` VALUES (185, '2018-07-04', '2018-07');
INSERT INTO `sys_calendar` VALUES (186, '2018-07-05', '2018-07');
INSERT INTO `sys_calendar` VALUES (187, '2018-07-06', '2018-07');
INSERT INTO `sys_calendar` VALUES (188, '2018-07-07', '2018-07');
INSERT INTO `sys_calendar` VALUES (189, '2018-07-08', '2018-07');
INSERT INTO `sys_calendar` VALUES (190, '2018-07-09', '2018-07');
INSERT INTO `sys_calendar` VALUES (191, '2018-07-10', '2018-07');
INSERT INTO `sys_calendar` VALUES (192, '2018-07-11', '2018-07');
INSERT INTO `sys_calendar` VALUES (193, '2018-07-12', '2018-07');
INSERT INTO `sys_calendar` VALUES (194, '2018-07-13', '2018-07');
INSERT INTO `sys_calendar` VALUES (195, '2018-07-14', '2018-07');
INSERT INTO `sys_calendar` VALUES (196, '2018-07-15', '2018-07');
INSERT INTO `sys_calendar` VALUES (197, '2018-07-16', '2018-07');
INSERT INTO `sys_calendar` VALUES (198, '2018-07-17', '2018-07');
INSERT INTO `sys_calendar` VALUES (199, '2018-07-18', '2018-07');
INSERT INTO `sys_calendar` VALUES (200, '2018-07-19', '2018-07');
INSERT INTO `sys_calendar` VALUES (201, '2018-07-20', '2018-07');
INSERT INTO `sys_calendar` VALUES (202, '2018-07-21', '2018-07');
INSERT INTO `sys_calendar` VALUES (203, '2018-07-22', '2018-07');
INSERT INTO `sys_calendar` VALUES (204, '2018-07-23', '2018-07');
INSERT INTO `sys_calendar` VALUES (205, '2018-07-24', '2018-07');
INSERT INTO `sys_calendar` VALUES (206, '2018-07-25', '2018-07');
INSERT INTO `sys_calendar` VALUES (207, '2018-07-26', '2018-07');
INSERT INTO `sys_calendar` VALUES (208, '2018-07-27', '2018-07');
INSERT INTO `sys_calendar` VALUES (209, '2018-07-28', '2018-07');
INSERT INTO `sys_calendar` VALUES (210, '2018-07-29', '2018-07');
INSERT INTO `sys_calendar` VALUES (211, '2018-07-30', '2018-07');
INSERT INTO `sys_calendar` VALUES (212, '2018-07-31', '2018-07');
INSERT INTO `sys_calendar` VALUES (213, '2018-08-01', '2018-08');
INSERT INTO `sys_calendar` VALUES (214, '2018-08-02', '2018-08');
INSERT INTO `sys_calendar` VALUES (215, '2018-08-03', '2018-08');
INSERT INTO `sys_calendar` VALUES (216, '2018-08-04', '2018-08');
INSERT INTO `sys_calendar` VALUES (217, '2018-08-05', '2018-08');
INSERT INTO `sys_calendar` VALUES (218, '2018-08-06', '2018-08');
INSERT INTO `sys_calendar` VALUES (219, '2018-08-07', '2018-08');
INSERT INTO `sys_calendar` VALUES (220, '2018-08-08', '2018-08');
INSERT INTO `sys_calendar` VALUES (221, '2018-08-09', '2018-08');
INSERT INTO `sys_calendar` VALUES (222, '2018-08-10', '2018-08');
INSERT INTO `sys_calendar` VALUES (223, '2018-08-11', '2018-08');
INSERT INTO `sys_calendar` VALUES (224, '2018-08-12', '2018-08');
INSERT INTO `sys_calendar` VALUES (225, '2018-08-13', '2018-08');
INSERT INTO `sys_calendar` VALUES (226, '2018-08-14', '2018-08');
INSERT INTO `sys_calendar` VALUES (227, '2018-08-15', '2018-08');
INSERT INTO `sys_calendar` VALUES (228, '2018-08-16', '2018-08');
INSERT INTO `sys_calendar` VALUES (229, '2018-08-17', '2018-08');
INSERT INTO `sys_calendar` VALUES (230, '2018-08-18', '2018-08');
INSERT INTO `sys_calendar` VALUES (231, '2018-08-19', '2018-08');
INSERT INTO `sys_calendar` VALUES (232, '2018-08-20', '2018-08');
INSERT INTO `sys_calendar` VALUES (233, '2018-08-21', '2018-08');
INSERT INTO `sys_calendar` VALUES (234, '2018-08-22', '2018-08');
INSERT INTO `sys_calendar` VALUES (235, '2018-08-23', '2018-08');
INSERT INTO `sys_calendar` VALUES (236, '2018-08-24', '2018-08');
INSERT INTO `sys_calendar` VALUES (237, '2018-08-25', '2018-08');
INSERT INTO `sys_calendar` VALUES (238, '2018-08-26', '2018-08');
INSERT INTO `sys_calendar` VALUES (239, '2018-08-27', '2018-08');
INSERT INTO `sys_calendar` VALUES (240, '2018-08-28', '2018-08');
INSERT INTO `sys_calendar` VALUES (241, '2018-08-29', '2018-08');
INSERT INTO `sys_calendar` VALUES (242, '2018-08-30', '2018-08');
INSERT INTO `sys_calendar` VALUES (243, '2018-08-31', '2018-08');
INSERT INTO `sys_calendar` VALUES (244, '2018-09-01', '2018-09');
INSERT INTO `sys_calendar` VALUES (245, '2018-09-02', '2018-09');
INSERT INTO `sys_calendar` VALUES (246, '2018-09-03', '2018-09');
INSERT INTO `sys_calendar` VALUES (247, '2018-09-04', '2018-09');
INSERT INTO `sys_calendar` VALUES (248, '2018-09-05', '2018-09');
INSERT INTO `sys_calendar` VALUES (249, '2018-09-06', '2018-09');
INSERT INTO `sys_calendar` VALUES (250, '2018-09-07', '2018-09');
INSERT INTO `sys_calendar` VALUES (251, '2018-09-08', '2018-09');
INSERT INTO `sys_calendar` VALUES (252, '2018-09-09', '2018-09');
INSERT INTO `sys_calendar` VALUES (253, '2018-09-10', '2018-09');
INSERT INTO `sys_calendar` VALUES (254, '2018-09-11', '2018-09');
INSERT INTO `sys_calendar` VALUES (255, '2018-09-12', '2018-09');
INSERT INTO `sys_calendar` VALUES (256, '2018-09-13', '2018-09');
INSERT INTO `sys_calendar` VALUES (257, '2018-09-14', '2018-09');
INSERT INTO `sys_calendar` VALUES (258, '2018-09-15', '2018-09');
INSERT INTO `sys_calendar` VALUES (259, '2018-09-16', '2018-09');
INSERT INTO `sys_calendar` VALUES (260, '2018-09-17', '2018-09');
INSERT INTO `sys_calendar` VALUES (261, '2018-09-18', '2018-09');
INSERT INTO `sys_calendar` VALUES (262, '2018-09-19', '2018-09');
INSERT INTO `sys_calendar` VALUES (263, '2018-09-20', '2018-09');
INSERT INTO `sys_calendar` VALUES (264, '2018-09-21', '2018-09');
INSERT INTO `sys_calendar` VALUES (265, '2018-09-22', '2018-09');
INSERT INTO `sys_calendar` VALUES (266, '2018-09-23', '2018-09');
INSERT INTO `sys_calendar` VALUES (267, '2018-09-24', '2018-09');
INSERT INTO `sys_calendar` VALUES (268, '2018-09-25', '2018-09');
INSERT INTO `sys_calendar` VALUES (269, '2018-09-26', '2018-09');
INSERT INTO `sys_calendar` VALUES (270, '2018-09-27', '2018-09');
INSERT INTO `sys_calendar` VALUES (271, '2018-09-28', '2018-09');
INSERT INTO `sys_calendar` VALUES (272, '2018-09-29', '2018-09');
INSERT INTO `sys_calendar` VALUES (273, '2018-09-30', '2018-09');
INSERT INTO `sys_calendar` VALUES (274, '2018-10-01', '2018-10');
INSERT INTO `sys_calendar` VALUES (275, '2018-10-02', '2018-10');
INSERT INTO `sys_calendar` VALUES (276, '2018-10-03', '2018-10');
INSERT INTO `sys_calendar` VALUES (277, '2018-10-04', '2018-10');
INSERT INTO `sys_calendar` VALUES (278, '2018-10-05', '2018-10');
INSERT INTO `sys_calendar` VALUES (279, '2018-10-06', '2018-10');
INSERT INTO `sys_calendar` VALUES (280, '2018-10-07', '2018-10');
INSERT INTO `sys_calendar` VALUES (281, '2018-10-08', '2018-10');
INSERT INTO `sys_calendar` VALUES (282, '2018-10-09', '2018-10');
INSERT INTO `sys_calendar` VALUES (283, '2018-10-10', '2018-10');
INSERT INTO `sys_calendar` VALUES (284, '2018-10-11', '2018-10');
INSERT INTO `sys_calendar` VALUES (285, '2018-10-12', '2018-10');
INSERT INTO `sys_calendar` VALUES (286, '2018-10-13', '2018-10');
INSERT INTO `sys_calendar` VALUES (287, '2018-10-14', '2018-10');
INSERT INTO `sys_calendar` VALUES (288, '2018-10-15', '2018-10');
INSERT INTO `sys_calendar` VALUES (289, '2018-10-16', '2018-10');
INSERT INTO `sys_calendar` VALUES (290, '2018-10-17', '2018-10');
INSERT INTO `sys_calendar` VALUES (291, '2018-10-18', '2018-10');
INSERT INTO `sys_calendar` VALUES (292, '2018-10-19', '2018-10');
INSERT INTO `sys_calendar` VALUES (293, '2018-10-20', '2018-10');
INSERT INTO `sys_calendar` VALUES (294, '2018-10-21', '2018-10');
INSERT INTO `sys_calendar` VALUES (295, '2018-10-22', '2018-10');
INSERT INTO `sys_calendar` VALUES (296, '2018-10-23', '2018-10');
INSERT INTO `sys_calendar` VALUES (297, '2018-10-24', '2018-10');
INSERT INTO `sys_calendar` VALUES (298, '2018-10-25', '2018-10');
INSERT INTO `sys_calendar` VALUES (299, '2018-10-26', '2018-10');
INSERT INTO `sys_calendar` VALUES (300, '2018-10-27', '2018-10');
INSERT INTO `sys_calendar` VALUES (301, '2018-10-28', '2018-10');
INSERT INTO `sys_calendar` VALUES (302, '2018-10-29', '2018-10');
INSERT INTO `sys_calendar` VALUES (303, '2018-10-30', '2018-10');
INSERT INTO `sys_calendar` VALUES (304, '2018-10-31', '2018-10');
INSERT INTO `sys_calendar` VALUES (305, '2018-11-01', '2018-11');
INSERT INTO `sys_calendar` VALUES (306, '2018-11-02', '2018-11');
INSERT INTO `sys_calendar` VALUES (307, '2018-11-03', '2018-11');
INSERT INTO `sys_calendar` VALUES (308, '2018-11-04', '2018-11');
INSERT INTO `sys_calendar` VALUES (309, '2018-11-05', '2018-11');
INSERT INTO `sys_calendar` VALUES (310, '2018-11-06', '2018-11');
INSERT INTO `sys_calendar` VALUES (311, '2018-11-07', '2018-11');
INSERT INTO `sys_calendar` VALUES (312, '2018-11-08', '2018-11');
INSERT INTO `sys_calendar` VALUES (313, '2018-11-09', '2018-11');
INSERT INTO `sys_calendar` VALUES (314, '2018-11-10', '2018-11');
INSERT INTO `sys_calendar` VALUES (315, '2018-11-11', '2018-11');
INSERT INTO `sys_calendar` VALUES (316, '2018-11-12', '2018-11');
INSERT INTO `sys_calendar` VALUES (317, '2018-11-13', '2018-11');
INSERT INTO `sys_calendar` VALUES (318, '2018-11-14', '2018-11');
INSERT INTO `sys_calendar` VALUES (319, '2018-11-15', '2018-11');
INSERT INTO `sys_calendar` VALUES (320, '2018-11-16', '2018-11');
INSERT INTO `sys_calendar` VALUES (321, '2018-11-17', '2018-11');
INSERT INTO `sys_calendar` VALUES (322, '2018-11-18', '2018-11');
INSERT INTO `sys_calendar` VALUES (323, '2018-11-19', '2018-11');
INSERT INTO `sys_calendar` VALUES (324, '2018-11-20', '2018-11');
INSERT INTO `sys_calendar` VALUES (325, '2018-11-21', '2018-11');
INSERT INTO `sys_calendar` VALUES (326, '2018-11-22', '2018-11');
INSERT INTO `sys_calendar` VALUES (327, '2018-11-23', '2018-11');
INSERT INTO `sys_calendar` VALUES (328, '2018-11-24', '2018-11');
INSERT INTO `sys_calendar` VALUES (329, '2018-11-25', '2018-11');
INSERT INTO `sys_calendar` VALUES (330, '2018-11-26', '2018-11');
INSERT INTO `sys_calendar` VALUES (331, '2018-11-27', '2018-11');
INSERT INTO `sys_calendar` VALUES (332, '2018-11-28', '2018-11');
INSERT INTO `sys_calendar` VALUES (333, '2018-11-29', '2018-11');
INSERT INTO `sys_calendar` VALUES (334, '2018-11-30', '2018-11');
INSERT INTO `sys_calendar` VALUES (335, '2018-12-01', '2018-12');
INSERT INTO `sys_calendar` VALUES (336, '2018-12-02', '2018-12');
INSERT INTO `sys_calendar` VALUES (337, '2018-12-03', '2018-12');
INSERT INTO `sys_calendar` VALUES (338, '2018-12-04', '2018-12');
INSERT INTO `sys_calendar` VALUES (339, '2018-12-05', '2018-12');
INSERT INTO `sys_calendar` VALUES (340, '2018-12-06', '2018-12');
INSERT INTO `sys_calendar` VALUES (341, '2018-12-07', '2018-12');
INSERT INTO `sys_calendar` VALUES (342, '2018-12-08', '2018-12');
INSERT INTO `sys_calendar` VALUES (343, '2018-12-09', '2018-12');
INSERT INTO `sys_calendar` VALUES (344, '2018-12-10', '2018-12');
INSERT INTO `sys_calendar` VALUES (345, '2018-12-11', '2018-12');
INSERT INTO `sys_calendar` VALUES (346, '2018-12-12', '2018-12');
INSERT INTO `sys_calendar` VALUES (347, '2018-12-13', '2018-12');
INSERT INTO `sys_calendar` VALUES (348, '2018-12-14', '2018-12');
INSERT INTO `sys_calendar` VALUES (349, '2018-12-15', '2018-12');
INSERT INTO `sys_calendar` VALUES (350, '2018-12-16', '2018-12');
INSERT INTO `sys_calendar` VALUES (351, '2018-12-17', '2018-12');
INSERT INTO `sys_calendar` VALUES (352, '2018-12-18', '2018-12');
INSERT INTO `sys_calendar` VALUES (353, '2018-12-19', '2018-12');
INSERT INTO `sys_calendar` VALUES (354, '2018-12-20', '2018-12');
INSERT INTO `sys_calendar` VALUES (355, '2018-12-21', '2018-12');
INSERT INTO `sys_calendar` VALUES (356, '2018-12-22', '2018-12');
INSERT INTO `sys_calendar` VALUES (357, '2018-12-23', '2018-12');
INSERT INTO `sys_calendar` VALUES (358, '2018-12-24', '2018-12');
INSERT INTO `sys_calendar` VALUES (359, '2018-12-25', '2018-12');
INSERT INTO `sys_calendar` VALUES (360, '2018-12-26', '2018-12');
INSERT INTO `sys_calendar` VALUES (361, '2018-12-27', '2018-12');
INSERT INTO `sys_calendar` VALUES (362, '2018-12-28', '2018-12');
INSERT INTO `sys_calendar` VALUES (363, '2018-12-29', '2018-12');
INSERT INTO `sys_calendar` VALUES (364, '2018-12-30', '2018-12');
INSERT INTO `sys_calendar` VALUES (365, '2018-12-31', '2018-12');
INSERT INTO `sys_calendar` VALUES (366, '2008-01-01', '2008-01');
INSERT INTO `sys_calendar` VALUES (367, '2008-01-02', '2008-01');
INSERT INTO `sys_calendar` VALUES (368, '2008-01-03', '2008-01');
INSERT INTO `sys_calendar` VALUES (369, '2008-01-04', '2008-01');
INSERT INTO `sys_calendar` VALUES (370, '2008-01-05', '2008-01');
INSERT INTO `sys_calendar` VALUES (371, '2008-01-06', '2008-01');
INSERT INTO `sys_calendar` VALUES (372, '2008-01-07', '2008-01');
INSERT INTO `sys_calendar` VALUES (373, '2008-01-08', '2008-01');
INSERT INTO `sys_calendar` VALUES (374, '2008-01-09', '2008-01');
INSERT INTO `sys_calendar` VALUES (375, '2008-01-10', '2008-01');
INSERT INTO `sys_calendar` VALUES (376, '2008-01-11', '2008-01');
INSERT INTO `sys_calendar` VALUES (377, '2008-01-12', '2008-01');
INSERT INTO `sys_calendar` VALUES (378, '2008-01-13', '2008-01');
INSERT INTO `sys_calendar` VALUES (379, '2008-01-14', '2008-01');
INSERT INTO `sys_calendar` VALUES (380, '2008-01-15', '2008-01');
INSERT INTO `sys_calendar` VALUES (381, '2008-01-16', '2008-01');
INSERT INTO `sys_calendar` VALUES (382, '2008-01-17', '2008-01');
INSERT INTO `sys_calendar` VALUES (383, '2008-01-18', '2008-01');
INSERT INTO `sys_calendar` VALUES (384, '2008-01-19', '2008-01');
INSERT INTO `sys_calendar` VALUES (385, '2008-01-20', '2008-01');
INSERT INTO `sys_calendar` VALUES (386, '2008-01-21', '2008-01');
INSERT INTO `sys_calendar` VALUES (387, '2008-01-22', '2008-01');
INSERT INTO `sys_calendar` VALUES (388, '2008-01-23', '2008-01');
INSERT INTO `sys_calendar` VALUES (389, '2008-01-24', '2008-01');
INSERT INTO `sys_calendar` VALUES (390, '2008-01-25', '2008-01');
INSERT INTO `sys_calendar` VALUES (391, '2008-01-26', '2008-01');
INSERT INTO `sys_calendar` VALUES (392, '2008-01-27', '2008-01');
INSERT INTO `sys_calendar` VALUES (393, '2008-01-28', '2008-01');
INSERT INTO `sys_calendar` VALUES (394, '2008-01-29', '2008-01');
INSERT INTO `sys_calendar` VALUES (395, '2008-01-30', '2008-01');
INSERT INTO `sys_calendar` VALUES (396, '2008-01-31', '2008-01');

-- ----------------------------
-- Table structure for sys_captcha
-- ----------------------------
DROP TABLE IF EXISTS `sys_captcha`;
CREATE TABLE `sys_captcha`  (
  `id` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `namespace` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `code_display` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created` bigint(20) NOT NULL,
  `audio_data` longblob NULL,
  PRIMARY KEY (`id`, `namespace`) USING BTREE,
  INDEX `idx_35968_created`(`created`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sys_classifications
-- ----------------------------
DROP TABLE IF EXISTS `sys_classifications`;
CREATE TABLE `sys_classifications`  (
  `tcs_id` int(11) NOT NULL AUTO_INCREMENT,
  `tcs_code` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tcs_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tcs_desc` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tcs_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_classifications
-- ----------------------------
INSERT INTO `sys_classifications` VALUES (1, '000', 'UMUM', NULL);
INSERT INTO `sys_classifications` VALUES (2, '010', 'Urusan Dalam', NULL);
INSERT INTO `sys_classifications` VALUES (3, '030', 'Kekayaan Daerah', NULL);
INSERT INTO `sys_classifications` VALUES (4, '040', 'Perpustakaan / Dokumen / Kearsipan / Sandi', NULL);
INSERT INTO `sys_classifications` VALUES (5, '050', 'Perencanaan', NULL);
INSERT INTO `sys_classifications` VALUES (6, '060', 'Organisasi / Ketatalaksanaan', NULL);
INSERT INTO `sys_classifications` VALUES (7, '070', 'Penelitian', NULL);
INSERT INTO `sys_classifications` VALUES (8, '080', 'Konperensi', NULL);
INSERT INTO `sys_classifications` VALUES (9, '090', 'Perjalanan Dinas', NULL);
INSERT INTO `sys_classifications` VALUES (10, '100', 'PEMERINTAHAN', NULL);
INSERT INTO `sys_classifications` VALUES (11, '110', 'Pemerintahan Pusat', NULL);
INSERT INTO `sys_classifications` VALUES (12, '120', 'Pemda TK. I', NULL);
INSERT INTO `sys_classifications` VALUES (13, '130', 'Pemda TK. II', NULL);
INSERT INTO `sys_classifications` VALUES (14, '140', 'Pemerintahan Desa', NULL);
INSERT INTO `sys_classifications` VALUES (15, '150', 'DPR - MPR', NULL);
INSERT INTO `sys_classifications` VALUES (16, '160', 'DPRD TK. I', NULL);
INSERT INTO `sys_classifications` VALUES (17, '170', 'DPRD TK. II', NULL);
INSERT INTO `sys_classifications` VALUES (18, '180', 'Hukum', NULL);
INSERT INTO `sys_classifications` VALUES (19, '190', 'Hubungan Luar Negeri', NULL);
INSERT INTO `sys_classifications` VALUES (20, '200', 'POLITIK', NULL);
INSERT INTO `sys_classifications` VALUES (21, '210', 'Kepartaian', NULL);
INSERT INTO `sys_classifications` VALUES (22, '220', 'Organisasi Kemasyarakatan', NULL);
INSERT INTO `sys_classifications` VALUES (23, '230', 'Organisasi Profesi dan Fungsional', NULL);
INSERT INTO `sys_classifications` VALUES (24, '240', 'Organisasi Pemuda', NULL);
INSERT INTO `sys_classifications` VALUES (25, '250', 'Organisasi Buruh, Tani dan Nelayan', NULL);
INSERT INTO `sys_classifications` VALUES (26, '260', 'Organisasi Wanita', NULL);
INSERT INTO `sys_classifications` VALUES (27, '270', 'Pemilihan Umum', NULL);

-- ----------------------------
-- Table structure for sys_company
-- ----------------------------
DROP TABLE IF EXISTS `sys_company`;
CREATE TABLE `sys_company`  (
  `scp_id` int(11) NOT NULL AUTO_INCREMENT,
  `scp_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `scp_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `scp_city` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `scp_state` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `scp_zip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `scp_phone` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `scp_fax` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `scp_email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `scp_homepage` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `scp_default` int(1) NULL DEFAULT 1,
  `scp_logo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`scp_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_company
-- ----------------------------
INSERT INTO `sys_company` VALUES (1, 'Pusdiklat Tenaga Administrasi', 'Jl. Kemerdekaan No. 45, Ciputat, Tangerang Selatan', 'Jakarta', 'Jakarta', '53183', '(021) 77126162', '(021) 77182717', 'pusdikadm@kemenag.go.id', 'http://pta.kemenag.go.id', 1, 'dc5eb9af6b884bb48aa712519b727ff4.png');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `sc_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sc_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sc_value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sc_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, 'app_id', '21000182918');
INSERT INTO `sys_config` VALUES (3, 'app_title', 'E-LKH');
INSERT INTO `sys_config` VALUES (4, 'app_version', '2.0.5');
INSERT INTO `sys_config` VALUES (5, 'app_description', 'Aplikasi input data sasaran kerja pegawai');
INSERT INTO `sys_config` VALUES (6, 'app_keywords', '');
INSERT INTO `sys_config` VALUES (7, 'app_author', 'pusdikadm');
INSERT INTO `sys_config` VALUES (8, 'app_repository', '');
INSERT INTO `sys_config` VALUES (9, 'app_token', '');
INSERT INTO `sys_config` VALUES (10, 'app_package', 'FREE');
INSERT INTO `sys_config` VALUES (11, 'app_limit', '5');
INSERT INTO `sys_config` VALUES (12, 'app_package_approval', '1');
INSERT INTO `sys_config` VALUES (13, 'app_pricing', '70000');
INSERT INTO `sys_config` VALUES (14, 'app_package_desc', 'Free account for your daily needs');
INSERT INTO `sys_config` VALUES (15, 'notif_global', 'You are on Free Package. <a  href=\"billing\"><b>Upgrade PRO Package </b></a> to unlock more features');
INSERT INTO `sys_config` VALUES (16, 'app_route_fallback', '/worksheet');

-- ----------------------------
-- Table structure for sys_constants
-- ----------------------------
DROP TABLE IF EXISTS `sys_constants`;
CREATE TABLE `sys_constants`  (
  `sco_id` int(11) NOT NULL AUTO_INCREMENT,
  `sco_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sco_value` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sco_desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sco_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_constants
-- ----------------------------
INSERT INTO `sys_constants` VALUES (1, 'DURATION_TOLERANCE', '24', 'Toleransi persentase waktu');
INSERT INTO `sys_constants` VALUES (2, 'COST_TOLERANCE', '24', 'Toleransi persentase biaya');
INSERT INTO `sys_constants` VALUES (3, 'DURATION_LIMIT', '76', 'Persentase waktu maksimum');
INSERT INTO `sys_constants` VALUES (4, 'COST_LIMIT', '76', 'Persentase biaya maksimum');
INSERT INTO `sys_constants` VALUES (5, 'DURATION_FACTOR', '1.76', 'Faktor perhitungan durasi');
INSERT INTO `sys_constants` VALUES (6, 'COST_FACTOR', '1.76', 'Faktor perhitungan biaya');
INSERT INTO `sys_constants` VALUES (7, 'PERFORMANCE_PORTION', '60', 'Porsi penilaian SKP');
INSERT INTO `sys_constants` VALUES (8, 'BEHAVIOR_PORTION', '40', 'Porsi penilaian sikap');

-- ----------------------------
-- Table structure for sys_criteria
-- ----------------------------
DROP TABLE IF EXISTS `sys_criteria`;
CREATE TABLE `sys_criteria`  (
  `tcr_id` int(11) NOT NULL AUTO_INCREMENT,
  `tcr_max` double(15, 2) NULL DEFAULT NULL,
  `tcr_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tcr_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_criteria
-- ----------------------------
INSERT INTO `sys_criteria` VALUES (1, 50.99, 'Buruk');
INSERT INTO `sys_criteria` VALUES (2, 60.99, 'Kurang');
INSERT INTO `sys_criteria` VALUES (3, 75.99, 'Cukup');
INSERT INTO `sys_criteria` VALUES (4, 90.99, 'Baik');
INSERT INTO `sys_criteria` VALUES (5, 100.99, 'Sangat Baik');

-- ----------------------------
-- Table structure for sys_departments
-- ----------------------------
DROP TABLE IF EXISTS `sys_departments`;
CREATE TABLE `sys_departments`  (
  `sdp_id` int(11) NOT NULL AUTO_INCREMENT,
  `sdp_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sdp_evaluator` int(11) NULL DEFAULT NULL,
  `sdp_examiner` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`sdp_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_departments
-- ----------------------------
INSERT INTO `sys_departments` VALUES (1, 'Badan Litbang dan Diklat Kementerian Agama', 2, 3);
INSERT INTO `sys_departments` VALUES (2, 'Bagian Teknologi Informasi', 2, 4);
INSERT INTO `sys_departments` VALUES (3, 'Bagian Umum', NULL, NULL);

-- ----------------------------
-- Table structure for sys_grades
-- ----------------------------
DROP TABLE IF EXISTS `sys_grades`;
CREATE TABLE `sys_grades`  (
  `sg_id` int(11) NOT NULL AUTO_INCREMENT,
  `sg_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sg_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_grades
-- ----------------------------
INSERT INTO `sys_grades` VALUES (1, 'Juru Muda/Ia');
INSERT INTO `sys_grades` VALUES (2, 'Juru Muda Tingkat I/Ib');
INSERT INTO `sys_grades` VALUES (3, 'Juru/Ic');
INSERT INTO `sys_grades` VALUES (4, 'Juru Tingkat I/Id');
INSERT INTO `sys_grades` VALUES (5, 'Pengatur Muda/IIa');
INSERT INTO `sys_grades` VALUES (6, 'Pengatur Muda Tingkat I/IIb');
INSERT INTO `sys_grades` VALUES (7, 'Pengatur/IIc');
INSERT INTO `sys_grades` VALUES (8, 'Pengatur Tingkat I/IId');
INSERT INTO `sys_grades` VALUES (9, 'Penata Muda/IIIa');
INSERT INTO `sys_grades` VALUES (10, 'Penata Muda Tingkat I/IIIb');
INSERT INTO `sys_grades` VALUES (11, 'Penata/IIIc');
INSERT INTO `sys_grades` VALUES (12, 'Penata Tingkat I/IIId');
INSERT INTO `sys_grades` VALUES (13, 'Pembina/IVa');
INSERT INTO `sys_grades` VALUES (14, 'Pembina Tingkat I/IVb');
INSERT INTO `sys_grades` VALUES (15, 'Pembina Utama Muda/IVc');
INSERT INTO `sys_grades` VALUES (16, 'Pembina Utama Madya/IVd');
INSERT INTO `sys_grades` VALUES (17, 'Pembina Utama/IVe');
INSERT INTO `sys_grades` VALUES (18, 'Foobar/Xa');

-- ----------------------------
-- Table structure for sys_inbox
-- ----------------------------
DROP TABLE IF EXISTS `sys_inbox`;
CREATE TABLE `sys_inbox`  (
  `smi_id` int(11) NOT NULL AUTO_INCREMENT,
  `smi_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `smi_subject` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `smi_sender` int(11) NULL DEFAULT NULL,
  `smi_recipient` int(11) NULL DEFAULT NULL,
  `smi_receiving_dt` datetime(0) NULL DEFAULT NULL,
  `smi_text` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `smi_read` int(1) NULL DEFAULT 0,
  `smi_deleted` int(1) NULL DEFAULT 0,
  `smi_created_dt` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`smi_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sys_jobs
-- ----------------------------
DROP TABLE IF EXISTS `sys_jobs`;
CREATE TABLE `sys_jobs`  (
  `sj_id` int(11) NOT NULL AUTO_INCREMENT,
  `sj_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sj_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_jobs
-- ----------------------------
INSERT INTO `sys_jobs` VALUES (1, 'Penyusun Administrasi Diklat');
INSERT INTO `sys_jobs` VALUES (2, 'Kasubid Diklat Teknis Administrasi dan Fungsional');
INSERT INTO `sys_jobs` VALUES (3, 'Kepala Bidang  Penyelenggaraan Diklat ');
INSERT INTO `sys_jobs` VALUES (4, 'Kepala Pusdiklat Administrasi');
INSERT INTO `sys_jobs` VALUES (6, 'Staff Teknologi Informasi');
INSERT INTO `sys_jobs` VALUES (7, 'Staff Bagian Umum');

-- ----------------------------
-- Table structure for sys_labels
-- ----------------------------
DROP TABLE IF EXISTS `sys_labels`;
CREATE TABLE `sys_labels`  (
  `sl_label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sl_created_by` int(11) NULL DEFAULT NULL,
  `sl_created_dt` datetime(0) NULL DEFAULT NULL,
  `sl_color` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'var(--paper-blue-grey-500)',
  `sl_id` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`sl_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_labels
-- ----------------------------
INSERT INTO `sys_labels` VALUES ('bugs', 7, '2017-12-24 13:53:18', '#f44336', 11);
INSERT INTO `sys_labels` VALUES ('issue', 7, '2017-12-25 04:12:10', '#e91e63', 12);
INSERT INTO `sys_labels` VALUES ('opened', 7, '2017-12-25 04:12:43', '#9c27b0', 13);
INSERT INTO `sys_labels` VALUES ('test', 7, '2018-01-03 17:08:00', '#2196f3', 14);
INSERT INTO `sys_labels` VALUES ('closed', 7, '2018-01-18 23:01:10', '#009688', 15);
INSERT INTO `sys_labels` VALUES ('prioritas', 2, '2018-01-25 07:42:08', 'var(--paper-red-500)', 16);
INSERT INTO `sys_labels` VALUES ('koreksi', 2, '2018-01-25 08:06:30', 'var(--paper-amber-500)', 17);
INSERT INTO `sys_labels` VALUES ('valid', 2, '2018-01-25 08:06:47', 'var(--paper-green-500)', 18);

-- ----------------------------
-- Table structure for sys_menus
-- ----------------------------
DROP TABLE IF EXISTS `sys_menus`;
CREATE TABLE `sys_menus`  (
  `smn_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `smn_parent_id` bigint(20) NULL DEFAULT NULL,
  `smn_title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `smn_icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `smn_path` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `smn_order` bigint(20) NULL DEFAULT NULL,
  `smn_visible` int(11) NULL DEFAULT 1,
  `smn_default` int(11) NULL DEFAULT 0,
  `smn_group` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`smn_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_menus
-- ----------------------------
INSERT INTO `sys_menus` VALUES (1, 0, 'Homepage', 'social:public', '/home', 1000, 1, 1, NULL);
INSERT INTO `sys_menus` VALUES (3, 0, 'Kinerja Harian', 'description', '/lkh', 1400, 1, 0, 'Monitoring');
INSERT INTO `sys_menus` VALUES (7, 0, 'Konfigurasi', 'settings', '/settings', 1900, 1, 0, 'Aplikasi');
INSERT INTO `sys_menus` VALUES (19, 0, 'Administrasi', 'description', '/worksheet', 1300, 1, 0, 'Transaksi');
INSERT INTO `sys_menus` VALUES (20, 0, 'Referensi Label', 'label-outline', '/references/labels', 1700, 1, 0, 'Referensi');
INSERT INTO `sys_menus` VALUES (21, 0, 'Referensi Satuan', 'label-outline', '/references/units', 1800, 1, 0, NULL);
INSERT INTO `sys_menus` VALUES (22, 0, 'Notifikasi', 'social:notifications', '/notifications', 1200, 1, 0, NULL);
INSERT INTO `sys_menus` VALUES (23, 0, 'Sasaran Kerja', 'description', '/skp', 1500, 1, 0, NULL);
INSERT INTO `sys_menus` VALUES (24, 0, 'Pendaftaran', 'description', '/registration', 1600, 1, 0, NULL);
INSERT INTO `sys_menus` VALUES (25, 0, 'Absensi', 'description', '/presence', 1601, 0, 0, NULL);
INSERT INTO `sys_menus` VALUES (26, 0, 'Perpesanan', 'mail', '/messages', 1201, 0, 0, NULL);

-- ----------------------------
-- Table structure for sys_modules
-- ----------------------------
DROP TABLE IF EXISTS `sys_modules`;
CREATE TABLE `sys_modules`  (
  `sm_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sm_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sm_version` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sm_title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sm_author` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'KCT Team',
  `sm_repository` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sm_api` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sm_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_modules
-- ----------------------------
INSERT INTO `sys_modules` VALUES (2, 'auth', '1.0.0', 'Authentication', 'Londomloto', 'https://github.com/londomloto/pusdikadm.git', '/auth');
INSERT INTO `sys_modules` VALUES (3, 'application', '1.0.0', 'Application', 'Londomloto', 'https://github.com/londomloto/pusdikadm.git', '/');
INSERT INTO `sys_modules` VALUES (5, 'home', '1.0.0', 'Homepage', 'Londomloto', 'https://github.com/londomloto/pusdikadm.git', '/home');
INSERT INTO `sys_modules` VALUES (7, 'roles', '1.0.0', 'Roles', 'Londomloto', 'https://github.com/londomloto/pusdikadm.git', '/roles');
INSERT INTO `sys_modules` VALUES (8, 'users', '1.0.0', 'Users', 'Londomloto', 'https://github.com/londomloto/pusdikadm.git', '/users');
INSERT INTO `sys_modules` VALUES (9, 'modules', '1.0.0', 'Modules', 'Londomloto', 'https://github.com/londomloto/pusdikadm.git', '/modules');
INSERT INTO `sys_modules` VALUES (17, 'settings', '1.0.0', 'Settings', 'Londomloto', 'https://github.com/londomloto/pusdikadm.git', '/settings');
INSERT INTO `sys_modules` VALUES (18, 'worksheet', '1.0.0', 'Worksheet', 'Londomloto', 'https://github.com/londomloto/pusdikadm.git', '/worksheet');
INSERT INTO `sys_modules` VALUES (19, 'labels', '1.0.0', 'Labels', 'Londomloto', 'https://github.com/londomloto/pusdikadm.git', '/references/labels');
INSERT INTO `sys_modules` VALUES (20, 'units', '1.0.0', 'Satuan', 'Londomloto', NULL, '/references/units');
INSERT INTO `sys_modules` VALUES (21, 'notifications', '1.0.0', 'Notifications', 'Londomloto', NULL, '/notifications');
INSERT INTO `sys_modules` VALUES (24, 'registration', NULL, 'Registration', '', NULL, '/registration');
INSERT INTO `sys_modules` VALUES (26, 'messages', '1.0.0', 'Messaging', 'Pusdikadm', NULL, '/messages');
INSERT INTO `sys_modules` VALUES (27, 'lkh', '1.0.0', 'LKH', 'pusdikadm', NULL, '/lkh');
INSERT INTO `sys_modules` VALUES (28, 'skp', '1.0.0', 'SKP', 'pusdikadm', NULL, '/skp');
INSERT INTO `sys_modules` VALUES (29, 'grades', '1.0.0', 'Pangkat', 'Pusdikadm', NULL, '/references/grades');

-- ----------------------------
-- Table structure for sys_modules_capabilities
-- ----------------------------
DROP TABLE IF EXISTS `sys_modules_capabilities`;
CREATE TABLE `sys_modules_capabilities`  (
  `smc_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `smc_sm_id` bigint(20) NULL DEFAULT NULL,
  `smc_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `smc_description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`smc_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 59 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_modules_capabilities
-- ----------------------------
INSERT INTO `sys_modules_capabilities` VALUES (31, 2, 'login_browser', 'Mengizinkan user login dari browser');
INSERT INTO `sys_modules_capabilities` VALUES (32, 2, 'login_mobile', 'Mengizinkan user login dari perangkat mobile');
INSERT INTO `sys_modules_capabilities` VALUES (33, 3, 'manage', 'Mengatur keseluruhan aplikasi');
INSERT INTO `sys_modules_capabilities` VALUES (34, 27, 'access_monitoring', 'Mengizinkan user untuk mengakses menu monitoring');
INSERT INTO `sys_modules_capabilities` VALUES (35, 27, 'access_report', 'Mengizinkan user untuk mengakses menu report');
INSERT INTO `sys_modules_capabilities` VALUES (36, 27, 'access_database', 'Mengizinkan user untuk mengakses menu dokumen');
INSERT INTO `sys_modules_capabilities` VALUES (37, 27, 'access_dashboard', 'Mengizinkan user untuk mengakses menu dashboard');
INSERT INTO `sys_modules_capabilities` VALUES (38, 27, 'access_statistic', 'Mengizinkan user untuk mengakses menu statistik');
INSERT INTO `sys_modules_capabilities` VALUES (39, 27, 'access_database_items', 'Mengizinkan user untuk mengakses menu kegiatan');
INSERT INTO `sys_modules_capabilities` VALUES (40, 24, 'access_database', 'Mengizinkan user untuk mengakses menu database');
INSERT INTO `sys_modules_capabilities` VALUES (42, 24, 'access_statistic', 'Mengizinkan user mengakses menu statistik');
INSERT INTO `sys_modules_capabilities` VALUES (43, 24, 'access_dashboard', 'Mengizinkan user mengakses menu dashboard');
INSERT INTO `sys_modules_capabilities` VALUES (44, 17, 'manage_user', 'Mengizinkan user untuk mengelola data user');
INSERT INTO `sys_modules_capabilities` VALUES (45, 17, 'manage_bpmn', 'Mengizinkan user untuk merubah bisnis proses aplikasi');
INSERT INTO `sys_modules_capabilities` VALUES (46, 17, 'manage_company', 'Mengizinkan user untuk mengelola data organisasi');
INSERT INTO `sys_modules_capabilities` VALUES (47, 17, 'manage_app', 'Mengizinkan user untuk mengatur konfigurasi aplikasi');
INSERT INTO `sys_modules_capabilities` VALUES (48, 17, 'manage_role', 'Mengizinkan user mengelola data role');
INSERT INTO `sys_modules_capabilities` VALUES (49, 17, 'manage_perm', 'Mengizinkan user mengelola data akses');
INSERT INTO `sys_modules_capabilities` VALUES (51, 27, 'manage', 'Mengizinkan user untuk mengelola semua dokumen');
INSERT INTO `sys_modules_capabilities` VALUES (52, 28, 'manage', 'Mengizinkan user untuk mengelola seluruh dokumen');
INSERT INTO `sys_modules_capabilities` VALUES (53, 28, 'access_monitoring', 'Mengizinkan user mengakses menu monitoring');
INSERT INTO `sys_modules_capabilities` VALUES (54, 28, 'access_database', 'Mengizinkan user mengakses menu database');
INSERT INTO `sys_modules_capabilities` VALUES (55, 28, 'access_database_items', 'Mengizinkan user mengakses menu kegiatan');
INSERT INTO `sys_modules_capabilities` VALUES (56, 28, 'access_report', 'Mengizinkan user mengakses menu laporan');
INSERT INTO `sys_modules_capabilities` VALUES (57, 28, 'access_statistic', 'mengizinkan user mengakses menu statistik');
INSERT INTO `sys_modules_capabilities` VALUES (58, 28, 'access_dashboard', 'Mengizinkan user mengakses menu dashboard');

-- ----------------------------
-- Table structure for sys_numbers
-- ----------------------------
DROP TABLE IF EXISTS `sys_numbers`;
CREATE TABLE `sys_numbers`  (
  `sn_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sn_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sn_value` bigint(20) NULL DEFAULT NULL,
  `sn_length` bigint(20) NULL DEFAULT NULL,
  `sn_prefix` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sn_suffix` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sn_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_numbers
-- ----------------------------
INSERT INTO `sys_numbers` VALUES (1, 'SALES_TICKET', 36, 5, 'SP', NULL);

-- ----------------------------
-- Table structure for sys_outbox
-- ----------------------------
DROP TABLE IF EXISTS `sys_outbox`;
CREATE TABLE `sys_outbox`  (
  `smo_id` int(11) NOT NULL AUTO_INCREMENT,
  `smo_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `smo_sender` int(11) NULL DEFAULT NULL,
  `smo_sending` int(1) NULL DEFAULT 0,
  `smo_sending_dt` datetime(0) NULL DEFAULT NULL,
  `smo_subject` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `smo_text` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `smo_created_dt` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`smo_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sys_permissions
-- ----------------------------
DROP TABLE IF EXISTS `sys_permissions`;
CREATE TABLE `sys_permissions`  (
  `sp_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sp_sr_id` bigint(20) NULL DEFAULT NULL,
  `sp_smc_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`sp_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_permissions
-- ----------------------------
INSERT INTO `sys_permissions` VALUES (1, 1, 1);

-- ----------------------------
-- Table structure for sys_projects
-- ----------------------------
DROP TABLE IF EXISTS `sys_projects`;
CREATE TABLE `sys_projects`  (
  `sp_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sp_type` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'private',
  `sp_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sp_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sp_desc` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `sp_start_date` date NULL DEFAULT NULL,
  `sp_end_date` date NULL DEFAULT NULL,
  `sp_creator_id` bigint(20) NULL DEFAULT NULL,
  `sp_created_date` datetime(0) NULL DEFAULT NULL,
  `sp_worksheet_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`sp_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_projects
-- ----------------------------
INSERT INTO `sys_projects` VALUES (36, 'private', 'private', 'Private', NULL, NULL, NULL, 7, '2018-01-20 02:34:17', 19);
INSERT INTO `sys_projects` VALUES (39, 'private', 'pendaftaran', 'Pendaftaran', 'Module pendaftaran peserta', NULL, NULL, 1, '2018-01-24 07:02:26', 24);
INSERT INTO `sys_projects` VALUES (40, 'public', 'skp', 'SKP', 'Module manajemen dokumen SKP', NULL, NULL, 1, '2018-01-24 07:28:32', 25);
INSERT INTO `sys_projects` VALUES (41, 'public', 'lkh', 'LKH', 'Module agenda harian', NULL, NULL, 1, '2018-01-24 07:33:31', 26);
INSERT INTO `sys_projects` VALUES (43, 'private', 'surat-masuk', 'Surat Masuk', NULL, NULL, NULL, 1, '2018-04-27 05:08:39', 31);

-- ----------------------------
-- Table structure for sys_projects_labels
-- ----------------------------
DROP TABLE IF EXISTS `sys_projects_labels`;
CREATE TABLE `sys_projects_labels`  (
  `spl_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `spl_sp_id` bigint(20) NULL DEFAULT NULL,
  `spl_sl_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`spl_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sys_projects_users
-- ----------------------------
DROP TABLE IF EXISTS `sys_projects_users`;
CREATE TABLE `sys_projects_users`  (
  `spu_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `spu_sp_id` bigint(20) NULL DEFAULT NULL,
  `spu_su_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`spu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 99 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_projects_users
-- ----------------------------
INSERT INTO `sys_projects_users` VALUES (12, 20, 7);
INSERT INTO `sys_projects_users` VALUES (13, 21, 7);
INSERT INTO `sys_projects_users` VALUES (73, 36, 7);
INSERT INTO `sys_projects_users` VALUES (81, 39, 1);
INSERT INTO `sys_projects_users` VALUES (82, 40, 1);
INSERT INTO `sys_projects_users` VALUES (83, 41, 1);
INSERT INTO `sys_projects_users` VALUES (94, 39, 16);
INSERT INTO `sys_projects_users` VALUES (97, 43, 1);
INSERT INTO `sys_projects_users` VALUES (98, 43, 16);

-- ----------------------------
-- Table structure for sys_recipients
-- ----------------------------
DROP TABLE IF EXISTS `sys_recipients`;
CREATE TABLE `sys_recipients`  (
  `smr_id` int(11) NOT NULL AUTO_INCREMENT,
  `smr_smo_id` int(11) NULL DEFAULT NULL,
  `smr_recipient` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`smr_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sys_roles
-- ----------------------------
DROP TABLE IF EXISTS `sys_roles`;
CREATE TABLE `sys_roles`  (
  `sr_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sr_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sr_slug` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sr_description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sr_default` int(11) NULL DEFAULT 0,
  `sr_created_date` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP,
  `sr_created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'system',
  PRIMARY KEY (`sr_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_roles
-- ----------------------------
INSERT INTO `sys_roles` VALUES (4, 'Administator', 'administator', 'Role untuk administrator aplikasi', 1, '2017-05-24 18:48:45', 'system');
INSERT INTO `sys_roles` VALUES (7, 'Pemeriksa', 'pemeriksa', 'Role untuk pemeriksa dan penilai', 0, '2017-09-18 09:00:50', 'system');
INSERT INTO `sys_roles` VALUES (16, 'Atasan Pemeriksa', 'atasan-pemeriksa', 'Role untuk atasan pemeriksa', 0, '2018-01-11 10:27:53', 'system');
INSERT INTO `sys_roles` VALUES (18, 'Pegawai', 'pegawai', 'Role untuk pegawai (default)', 0, '2018-01-23 22:17:52', 'system');
INSERT INTO `sys_roles` VALUES (20, 'Operator', 'operator', 'Role untuk operator aplikasi', 0, '2018-01-28 02:39:02', 'system');

-- ----------------------------
-- Table structure for sys_roles_kanban
-- ----------------------------
DROP TABLE IF EXISTS `sys_roles_kanban`;
CREATE TABLE `sys_roles_kanban`  (
  `srk_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `srk_sr_id` bigint(20) NULL DEFAULT NULL,
  `srk_ks_id` bigint(20) NULL DEFAULT NULL,
  `srk_selected` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`srk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sys_roles_menus
-- ----------------------------
DROP TABLE IF EXISTS `sys_roles_menus`;
CREATE TABLE `sys_roles_menus`  (
  `srm_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `srm_sr_id` bigint(20) NULL DEFAULT NULL,
  `srm_smn_id` bigint(20) NULL DEFAULT NULL,
  `srm_sm_id` int(11) NULL DEFAULT NULL,
  `srm_selected` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`srm_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 148 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_roles_menus
-- ----------------------------
INSERT INTO `sys_roles_menus` VALUES (1, 4, 1, 5, 1);
INSERT INTO `sys_roles_menus` VALUES (8, 4, 7, 17, 1);
INSERT INTO `sys_roles_menus` VALUES (9, 4, 19, 18, 1);
INSERT INTO `sys_roles_menus` VALUES (10, 4, 20, 19, 1);
INSERT INTO `sys_roles_menus` VALUES (11, 16, 1, 5, 1);
INSERT INTO `sys_roles_menus` VALUES (12, 16, 3, 27, 1);
INSERT INTO `sys_roles_menus` VALUES (13, 16, 7, 17, 0);
INSERT INTO `sys_roles_menus` VALUES (14, 16, 19, 18, 1);
INSERT INTO `sys_roles_menus` VALUES (15, 16, 20, 19, 1);
INSERT INTO `sys_roles_menus` VALUES (17, 7, 19, 18, 1);
INSERT INTO `sys_roles_menus` VALUES (18, 7, 1, 5, 1);
INSERT INTO `sys_roles_menus` VALUES (19, 17, 1, 5, 1);
INSERT INTO `sys_roles_menus` VALUES (20, 17, 3, 27, 1);
INSERT INTO `sys_roles_menus` VALUES (21, 17, 19, 18, 1);
INSERT INTO `sys_roles_menus` VALUES (22, 18, 1, 5, 1);
INSERT INTO `sys_roles_menus` VALUES (23, 18, 3, 27, 1);
INSERT INTO `sys_roles_menus` VALUES (24, 18, 7, 17, 0);
INSERT INTO `sys_roles_menus` VALUES (25, 18, 19, 18, 1);
INSERT INTO `sys_roles_menus` VALUES (26, 18, 20, 19, 1);
INSERT INTO `sys_roles_menus` VALUES (27, 7, 3, 27, 1);
INSERT INTO `sys_roles_menus` VALUES (28, 7, 20, 19, 1);
INSERT INTO `sys_roles_menus` VALUES (29, 17, 7, 17, 0);
INSERT INTO `sys_roles_menus` VALUES (30, 17, 20, 19, 1);
INSERT INTO `sys_roles_menus` VALUES (31, 19, 1, NULL, 1);
INSERT INTO `sys_roles_menus` VALUES (32, 19, 3, NULL, 1);
INSERT INTO `sys_roles_menus` VALUES (33, 19, 19, NULL, 1);
INSERT INTO `sys_roles_menus` VALUES (34, 19, 20, NULL, 1);
INSERT INTO `sys_roles_menus` VALUES (35, 20, 1, 5, 1);
INSERT INTO `sys_roles_menus` VALUES (36, 20, 3, 27, 1);
INSERT INTO `sys_roles_menus` VALUES (37, 20, 7, 17, 1);
INSERT INTO `sys_roles_menus` VALUES (38, 20, 19, 18, 1);
INSERT INTO `sys_roles_menus` VALUES (39, 20, 20, 19, 1);
INSERT INTO `sys_roles_menus` VALUES (40, 4, 21, 20, 1);
INSERT INTO `sys_roles_menus` VALUES (41, 4, 22, 21, 1);
INSERT INTO `sys_roles_menus` VALUES (43, 4, 24, 24, 1);
INSERT INTO `sys_roles_menus` VALUES (44, 4, NULL, 9, 1);
INSERT INTO `sys_roles_menus` VALUES (45, 4, NULL, 7, 1);
INSERT INTO `sys_roles_menus` VALUES (46, 4, NULL, 8, 1);
INSERT INTO `sys_roles_menus` VALUES (47, 4, NULL, 3, 1);
INSERT INTO `sys_roles_menus` VALUES (49, 4, NULL, 2, 1);
INSERT INTO `sys_roles_menus` VALUES (52, 4, 26, 26, 1);
INSERT INTO `sys_roles_menus` VALUES (53, 4, 3, 27, 1);
INSERT INTO `sys_roles_menus` VALUES (55, 4, 23, 28, 1);
INSERT INTO `sys_roles_menus` VALUES (57, 17, NULL, 3, 0);
INSERT INTO `sys_roles_menus` VALUES (59, 17, NULL, 2, 0);
INSERT INTO `sys_roles_menus` VALUES (61, 17, 26, 26, 0);
INSERT INTO `sys_roles_menus` VALUES (62, 17, NULL, 9, 0);
INSERT INTO `sys_roles_menus` VALUES (63, 17, 22, 21, 1);
INSERT INTO `sys_roles_menus` VALUES (65, 17, 24, 24, 1);
INSERT INTO `sys_roles_menus` VALUES (67, 17, NULL, 7, 0);
INSERT INTO `sys_roles_menus` VALUES (68, 17, 21, 20, 1);
INSERT INTO `sys_roles_menus` VALUES (69, 17, 23, 28, 1);
INSERT INTO `sys_roles_menus` VALUES (71, 17, NULL, 8, 0);
INSERT INTO `sys_roles_menus` VALUES (72, 20, NULL, 3, 0);
INSERT INTO `sys_roles_menus` VALUES (73, 20, NULL, 2, 0);
INSERT INTO `sys_roles_menus` VALUES (74, 20, 26, 26, 0);
INSERT INTO `sys_roles_menus` VALUES (75, 20, NULL, 9, 0);
INSERT INTO `sys_roles_menus` VALUES (76, 20, 22, 21, 1);
INSERT INTO `sys_roles_menus` VALUES (77, 20, 24, 24, 1);
INSERT INTO `sys_roles_menus` VALUES (78, 20, NULL, 7, 0);
INSERT INTO `sys_roles_menus` VALUES (79, 20, 21, 20, 1);
INSERT INTO `sys_roles_menus` VALUES (80, 20, 23, 28, 1);
INSERT INTO `sys_roles_menus` VALUES (81, 20, NULL, 8, 1);
INSERT INTO `sys_roles_menus` VALUES (82, 22, NULL, 3, 0);
INSERT INTO `sys_roles_menus` VALUES (83, 22, NULL, 2, 0);
INSERT INTO `sys_roles_menus` VALUES (84, 22, 1, 5, 1);
INSERT INTO `sys_roles_menus` VALUES (85, 22, 20, 19, 1);
INSERT INTO `sys_roles_menus` VALUES (86, 22, 3, 27, 1);
INSERT INTO `sys_roles_menus` VALUES (87, 22, 26, 26, 0);
INSERT INTO `sys_roles_menus` VALUES (88, 22, NULL, 9, 0);
INSERT INTO `sys_roles_menus` VALUES (89, 22, 22, 21, 1);
INSERT INTO `sys_roles_menus` VALUES (90, 22, 24, 24, 1);
INSERT INTO `sys_roles_menus` VALUES (91, 22, NULL, 7, 0);
INSERT INTO `sys_roles_menus` VALUES (92, 22, 21, 20, 1);
INSERT INTO `sys_roles_menus` VALUES (93, 22, 7, 17, 0);
INSERT INTO `sys_roles_menus` VALUES (94, 22, 23, 28, 1);
INSERT INTO `sys_roles_menus` VALUES (95, 22, NULL, 8, 0);
INSERT INTO `sys_roles_menus` VALUES (96, 22, 19, 18, 1);
INSERT INTO `sys_roles_menus` VALUES (97, 21, NULL, 3, 0);
INSERT INTO `sys_roles_menus` VALUES (98, 21, NULL, 2, 0);
INSERT INTO `sys_roles_menus` VALUES (99, 21, 1, 5, 1);
INSERT INTO `sys_roles_menus` VALUES (100, 21, 20, 19, 1);
INSERT INTO `sys_roles_menus` VALUES (101, 21, 3, 27, 1);
INSERT INTO `sys_roles_menus` VALUES (102, 21, 26, 26, 0);
INSERT INTO `sys_roles_menus` VALUES (103, 21, NULL, 9, 0);
INSERT INTO `sys_roles_menus` VALUES (104, 21, 22, 21, 1);
INSERT INTO `sys_roles_menus` VALUES (105, 21, 24, 24, 1);
INSERT INTO `sys_roles_menus` VALUES (106, 21, NULL, 7, 0);
INSERT INTO `sys_roles_menus` VALUES (107, 21, 21, 20, 1);
INSERT INTO `sys_roles_menus` VALUES (108, 21, 7, 17, 0);
INSERT INTO `sys_roles_menus` VALUES (109, 21, 23, 28, 1);
INSERT INTO `sys_roles_menus` VALUES (110, 21, NULL, 8, 0);
INSERT INTO `sys_roles_menus` VALUES (111, 21, 19, 18, 1);
INSERT INTO `sys_roles_menus` VALUES (112, 16, NULL, 3, 0);
INSERT INTO `sys_roles_menus` VALUES (113, 16, NULL, 2, 0);
INSERT INTO `sys_roles_menus` VALUES (114, 16, 26, 26, 0);
INSERT INTO `sys_roles_menus` VALUES (115, 16, NULL, 9, 0);
INSERT INTO `sys_roles_menus` VALUES (116, 16, 22, 21, 1);
INSERT INTO `sys_roles_menus` VALUES (117, 16, 24, 24, 1);
INSERT INTO `sys_roles_menus` VALUES (118, 16, NULL, 7, 0);
INSERT INTO `sys_roles_menus` VALUES (119, 16, 21, 20, 1);
INSERT INTO `sys_roles_menus` VALUES (120, 16, 23, 28, 1);
INSERT INTO `sys_roles_menus` VALUES (121, 16, NULL, 8, 0);
INSERT INTO `sys_roles_menus` VALUES (122, 7, NULL, 3, 0);
INSERT INTO `sys_roles_menus` VALUES (123, 7, NULL, 2, 0);
INSERT INTO `sys_roles_menus` VALUES (124, 7, 26, 26, 0);
INSERT INTO `sys_roles_menus` VALUES (125, 7, NULL, 9, 0);
INSERT INTO `sys_roles_menus` VALUES (126, 7, 22, 21, 1);
INSERT INTO `sys_roles_menus` VALUES (127, 7, 24, 24, 1);
INSERT INTO `sys_roles_menus` VALUES (128, 7, NULL, 7, 0);
INSERT INTO `sys_roles_menus` VALUES (129, 7, 21, 20, 1);
INSERT INTO `sys_roles_menus` VALUES (130, 7, 7, 17, 0);
INSERT INTO `sys_roles_menus` VALUES (131, 7, 23, 28, 1);
INSERT INTO `sys_roles_menus` VALUES (132, 7, NULL, 8, 0);
INSERT INTO `sys_roles_menus` VALUES (133, 18, NULL, 3, 0);
INSERT INTO `sys_roles_menus` VALUES (134, 18, NULL, 2, 0);
INSERT INTO `sys_roles_menus` VALUES (135, 18, 26, 26, 0);
INSERT INTO `sys_roles_menus` VALUES (136, 18, NULL, 9, 0);
INSERT INTO `sys_roles_menus` VALUES (137, 18, 22, 21, 0);
INSERT INTO `sys_roles_menus` VALUES (138, 18, 24, 24, 0);
INSERT INTO `sys_roles_menus` VALUES (139, 18, NULL, 7, 0);
INSERT INTO `sys_roles_menus` VALUES (140, 18, 21, 20, 1);
INSERT INTO `sys_roles_menus` VALUES (141, 18, 23, 28, 1);
INSERT INTO `sys_roles_menus` VALUES (142, 18, NULL, 8, 0);
INSERT INTO `sys_roles_menus` VALUES (143, 4, NULL, 29, 1);
INSERT INTO `sys_roles_menus` VALUES (144, 7, NULL, 29, 0);
INSERT INTO `sys_roles_menus` VALUES (145, 16, NULL, 29, 0);
INSERT INTO `sys_roles_menus` VALUES (146, 20, NULL, 29, 0);
INSERT INTO `sys_roles_menus` VALUES (147, 18, NULL, 29, 0);

-- ----------------------------
-- Table structure for sys_roles_panels
-- ----------------------------
DROP TABLE IF EXISTS `sys_roles_panels`;
CREATE TABLE `sys_roles_panels`  (
  `srs_id` int(11) NOT NULL AUTO_INCREMENT,
  `srs_sp_id` int(11) NULL DEFAULT NULL,
  `srs_sr_id` int(11) NULL DEFAULT NULL,
  `srs_kp_id` int(11) NULL DEFAULT NULL,
  `srs_kst_id` int(11) NULL DEFAULT NULL,
  `srs_checked` int(1) NULL DEFAULT 0,
  PRIMARY KEY (`srs_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_roles_panels
-- ----------------------------
INSERT INTO `sys_roles_panels` VALUES (11, 37, 7, 80, 86, 0);
INSERT INTO `sys_roles_panels` VALUES (12, 37, 7, 80, 87, 0);
INSERT INTO `sys_roles_panels` VALUES (13, 37, 7, 80, 88, 0);
INSERT INTO `sys_roles_panels` VALUES (14, 37, 7, 80, 89, 0);
INSERT INTO `sys_roles_panels` VALUES (15, 37, 7, 80, 90, 0);
INSERT INTO `sys_roles_panels` VALUES (16, 37, 7, 82, 92, 0);
INSERT INTO `sys_roles_panels` VALUES (17, 37, 7, 83, 93, 0);
INSERT INTO `sys_roles_panels` VALUES (18, 37, 7, 84, 94, 0);
INSERT INTO `sys_roles_panels` VALUES (19, 37, 7, 85, 95, 0);
INSERT INTO `sys_roles_panels` VALUES (20, 37, 7, 86, 96, 0);
INSERT INTO `sys_roles_panels` VALUES (21, 37, 7, 87, 97, 0);
INSERT INTO `sys_roles_panels` VALUES (22, 37, 16, 80, 86, 0);
INSERT INTO `sys_roles_panels` VALUES (23, 37, 16, 80, 87, 0);
INSERT INTO `sys_roles_panels` VALUES (24, 37, 16, 80, 88, 0);
INSERT INTO `sys_roles_panels` VALUES (25, 37, 16, 80, 89, 0);
INSERT INTO `sys_roles_panels` VALUES (26, 37, 16, 80, 90, 0);
INSERT INTO `sys_roles_panels` VALUES (27, 37, 16, 81, 91, 0);
INSERT INTO `sys_roles_panels` VALUES (28, 37, 16, 83, 93, 0);
INSERT INTO `sys_roles_panels` VALUES (29, 37, 16, 84, 94, 0);
INSERT INTO `sys_roles_panels` VALUES (30, 37, 16, 85, 95, 0);
INSERT INTO `sys_roles_panels` VALUES (31, 37, 16, 86, 96, 0);
INSERT INTO `sys_roles_panels` VALUES (32, 37, 16, 87, 97, 0);
INSERT INTO `sys_roles_panels` VALUES (33, 37, 17, 80, 86, 0);
INSERT INTO `sys_roles_panels` VALUES (34, 37, 17, 80, 87, 0);
INSERT INTO `sys_roles_panels` VALUES (35, 37, 17, 80, 88, 0);
INSERT INTO `sys_roles_panels` VALUES (36, 37, 17, 80, 89, 0);
INSERT INTO `sys_roles_panels` VALUES (37, 37, 17, 80, 90, 0);
INSERT INTO `sys_roles_panels` VALUES (38, 37, 17, 85, 95, 0);
INSERT INTO `sys_roles_panels` VALUES (39, 37, 18, 81, 91, 0);
INSERT INTO `sys_roles_panels` VALUES (40, 37, 18, 82, 92, 0);
INSERT INTO `sys_roles_panels` VALUES (41, 37, 18, 83, 93, 0);
INSERT INTO `sys_roles_panels` VALUES (42, 37, 18, 84, 94, 0);

-- ----------------------------
-- Table structure for sys_roles_permissions
-- ----------------------------
DROP TABLE IF EXISTS `sys_roles_permissions`;
CREATE TABLE `sys_roles_permissions`  (
  `srp_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `srp_sr_id` bigint(20) NULL DEFAULT NULL,
  `srp_smc_id` bigint(20) NULL DEFAULT NULL,
  `srp_selected` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`srp_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 174 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_roles_permissions
-- ----------------------------
INSERT INTO `sys_roles_permissions` VALUES (12, 4, 24, 0);
INSERT INTO `sys_roles_permissions` VALUES (13, 4, 12, 0);
INSERT INTO `sys_roles_permissions` VALUES (14, 4, 3, 0);
INSERT INTO `sys_roles_permissions` VALUES (15, 4, 18, 0);
INSERT INTO `sys_roles_permissions` VALUES (16, 4, 19, 0);
INSERT INTO `sys_roles_permissions` VALUES (17, 4, 22, 0);
INSERT INTO `sys_roles_permissions` VALUES (18, 4, 23, 0);
INSERT INTO `sys_roles_permissions` VALUES (19, 4, 20, 0);
INSERT INTO `sys_roles_permissions` VALUES (20, 4, 25, 0);
INSERT INTO `sys_roles_permissions` VALUES (21, 4, 17, 0);
INSERT INTO `sys_roles_permissions` VALUES (22, 4, 16, 0);
INSERT INTO `sys_roles_permissions` VALUES (23, 4, 21, 0);
INSERT INTO `sys_roles_permissions` VALUES (24, 4, 26, 0);
INSERT INTO `sys_roles_permissions` VALUES (25, 4, 27, 0);
INSERT INTO `sys_roles_permissions` VALUES (26, 4, 28, 0);
INSERT INTO `sys_roles_permissions` VALUES (27, 4, 29, 0);
INSERT INTO `sys_roles_permissions` VALUES (28, 4, 30, 0);
INSERT INTO `sys_roles_permissions` VALUES (29, 4, 31, 1);
INSERT INTO `sys_roles_permissions` VALUES (30, 16, 32, 1);
INSERT INTO `sys_roles_permissions` VALUES (31, 16, 31, 1);
INSERT INTO `sys_roles_permissions` VALUES (32, 4, 32, 1);
INSERT INTO `sys_roles_permissions` VALUES (33, 7, 31, 1);
INSERT INTO `sys_roles_permissions` VALUES (34, 7, 32, 1);
INSERT INTO `sys_roles_permissions` VALUES (37, 18, 31, 1);
INSERT INTO `sys_roles_permissions` VALUES (38, 18, 32, 1);
INSERT INTO `sys_roles_permissions` VALUES (41, 20, 31, 1);
INSERT INTO `sys_roles_permissions` VALUES (42, 20, 32, 1);
INSERT INTO `sys_roles_permissions` VALUES (43, 4, 33, 1);
INSERT INTO `sys_roles_permissions` VALUES (45, 4, 34, 1);
INSERT INTO `sys_roles_permissions` VALUES (46, 4, 35, 1);
INSERT INTO `sys_roles_permissions` VALUES (47, 4, 36, 1);
INSERT INTO `sys_roles_permissions` VALUES (48, 4, 37, 1);
INSERT INTO `sys_roles_permissions` VALUES (53, 20, 34, 1);
INSERT INTO `sys_roles_permissions` VALUES (54, 20, 35, 1);
INSERT INTO `sys_roles_permissions` VALUES (55, 20, 36, 1);
INSERT INTO `sys_roles_permissions` VALUES (56, 20, 37, 1);
INSERT INTO `sys_roles_permissions` VALUES (57, 4, 38, 1);
INSERT INTO `sys_roles_permissions` VALUES (59, 20, 38, 1);
INSERT INTO `sys_roles_permissions` VALUES (60, 4, 39, 1);
INSERT INTO `sys_roles_permissions` VALUES (62, 20, 39, 1);
INSERT INTO `sys_roles_permissions` VALUES (63, 4, 40, 1);
INSERT INTO `sys_roles_permissions` VALUES (64, 4, 41, 0);
INSERT INTO `sys_roles_permissions` VALUES (65, 4, 42, 1);
INSERT INTO `sys_roles_permissions` VALUES (66, 4, 43, 1);
INSERT INTO `sys_roles_permissions` VALUES (91, 16, 34, 1);
INSERT INTO `sys_roles_permissions` VALUES (92, 16, 35, 1);
INSERT INTO `sys_roles_permissions` VALUES (93, 16, 36, 1);
INSERT INTO `sys_roles_permissions` VALUES (94, 16, 37, 1);
INSERT INTO `sys_roles_permissions` VALUES (95, 16, 38, 1);
INSERT INTO `sys_roles_permissions` VALUES (96, 16, 39, 1);
INSERT INTO `sys_roles_permissions` VALUES (97, 16, 40, 1);
INSERT INTO `sys_roles_permissions` VALUES (98, 16, 41, 0);
INSERT INTO `sys_roles_permissions` VALUES (99, 16, 42, 1);
INSERT INTO `sys_roles_permissions` VALUES (100, 16, 43, 1);
INSERT INTO `sys_roles_permissions` VALUES (101, 7, 34, 1);
INSERT INTO `sys_roles_permissions` VALUES (102, 7, 35, 1);
INSERT INTO `sys_roles_permissions` VALUES (103, 7, 36, 1);
INSERT INTO `sys_roles_permissions` VALUES (104, 7, 37, 1);
INSERT INTO `sys_roles_permissions` VALUES (105, 7, 38, 1);
INSERT INTO `sys_roles_permissions` VALUES (106, 7, 39, 1);
INSERT INTO `sys_roles_permissions` VALUES (107, 7, 40, 1);
INSERT INTO `sys_roles_permissions` VALUES (108, 7, 41, 0);
INSERT INTO `sys_roles_permissions` VALUES (109, 7, 42, 1);
INSERT INTO `sys_roles_permissions` VALUES (110, 7, 43, 1);
INSERT INTO `sys_roles_permissions` VALUES (111, 20, 40, 1);
INSERT INTO `sys_roles_permissions` VALUES (112, 20, 41, 0);
INSERT INTO `sys_roles_permissions` VALUES (113, 20, 42, 1);
INSERT INTO `sys_roles_permissions` VALUES (114, 20, 43, 1);
INSERT INTO `sys_roles_permissions` VALUES (115, 4, 44, 1);
INSERT INTO `sys_roles_permissions` VALUES (116, 4, 45, 1);
INSERT INTO `sys_roles_permissions` VALUES (117, 4, 46, 1);
INSERT INTO `sys_roles_permissions` VALUES (118, 4, 47, 1);
INSERT INTO `sys_roles_permissions` VALUES (119, 20, 44, 1);
INSERT INTO `sys_roles_permissions` VALUES (120, 20, 46, 1);
INSERT INTO `sys_roles_permissions` VALUES (121, 4, 48, 1);
INSERT INTO `sys_roles_permissions` VALUES (122, 4, 49, 1);
INSERT INTO `sys_roles_permissions` VALUES (123, 18, 34, 1);
INSERT INTO `sys_roles_permissions` VALUES (124, 18, 35, 1);
INSERT INTO `sys_roles_permissions` VALUES (125, 18, 36, 1);
INSERT INTO `sys_roles_permissions` VALUES (126, 18, 37, 1);
INSERT INTO `sys_roles_permissions` VALUES (127, 18, 38, 1);
INSERT INTO `sys_roles_permissions` VALUES (128, 18, 39, 1);
INSERT INTO `sys_roles_permissions` VALUES (131, 16, 33, 0);
INSERT INTO `sys_roles_permissions` VALUES (132, 7, 33, 0);
INSERT INTO `sys_roles_permissions` VALUES (133, 20, 33, 0);
INSERT INTO `sys_roles_permissions` VALUES (134, 4, 51, 1);
INSERT INTO `sys_roles_permissions` VALUES (137, 16, 51, 1);
INSERT INTO `sys_roles_permissions` VALUES (138, 7, 51, 1);
INSERT INTO `sys_roles_permissions` VALUES (139, 20, 51, 0);
INSERT INTO `sys_roles_permissions` VALUES (140, 4, 52, 1);
INSERT INTO `sys_roles_permissions` VALUES (141, 7, 52, 1);
INSERT INTO `sys_roles_permissions` VALUES (142, 16, 52, 1);
INSERT INTO `sys_roles_permissions` VALUES (143, 20, 52, 0);
INSERT INTO `sys_roles_permissions` VALUES (144, 4, 53, 1);
INSERT INTO `sys_roles_permissions` VALUES (145, 4, 54, 1);
INSERT INTO `sys_roles_permissions` VALUES (146, 4, 55, 1);
INSERT INTO `sys_roles_permissions` VALUES (147, 4, 56, 1);
INSERT INTO `sys_roles_permissions` VALUES (148, 4, 57, 1);
INSERT INTO `sys_roles_permissions` VALUES (149, 4, 58, 1);
INSERT INTO `sys_roles_permissions` VALUES (150, 16, 53, 1);
INSERT INTO `sys_roles_permissions` VALUES (151, 16, 54, 1);
INSERT INTO `sys_roles_permissions` VALUES (152, 16, 55, 1);
INSERT INTO `sys_roles_permissions` VALUES (153, 16, 56, 1);
INSERT INTO `sys_roles_permissions` VALUES (154, 16, 57, 1);
INSERT INTO `sys_roles_permissions` VALUES (155, 16, 58, 1);
INSERT INTO `sys_roles_permissions` VALUES (156, 20, 53, 1);
INSERT INTO `sys_roles_permissions` VALUES (157, 20, 54, 1);
INSERT INTO `sys_roles_permissions` VALUES (158, 20, 55, 1);
INSERT INTO `sys_roles_permissions` VALUES (159, 20, 56, 1);
INSERT INTO `sys_roles_permissions` VALUES (160, 20, 57, 1);
INSERT INTO `sys_roles_permissions` VALUES (161, 20, 58, 1);
INSERT INTO `sys_roles_permissions` VALUES (162, 18, 53, 1);
INSERT INTO `sys_roles_permissions` VALUES (163, 18, 54, 1);
INSERT INTO `sys_roles_permissions` VALUES (164, 18, 55, 1);
INSERT INTO `sys_roles_permissions` VALUES (165, 18, 56, 1);
INSERT INTO `sys_roles_permissions` VALUES (166, 18, 57, 1);
INSERT INTO `sys_roles_permissions` VALUES (167, 18, 58, 1);
INSERT INTO `sys_roles_permissions` VALUES (168, 7, 53, 1);
INSERT INTO `sys_roles_permissions` VALUES (169, 7, 54, 1);
INSERT INTO `sys_roles_permissions` VALUES (170, 7, 55, 1);
INSERT INTO `sys_roles_permissions` VALUES (171, 7, 56, 1);
INSERT INTO `sys_roles_permissions` VALUES (172, 7, 57, 1);
INSERT INTO `sys_roles_permissions` VALUES (173, 7, 58, 1);

-- ----------------------------
-- Table structure for sys_units
-- ----------------------------
DROP TABLE IF EXISTS `sys_units`;
CREATE TABLE `sys_units`  (
  `sun_id` int(11) NOT NULL AUTO_INCREMENT,
  `sun_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sun_id`) USING BTREE,
  INDEX `sun_idx_0`(`sun_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_units
-- ----------------------------
INSERT INTO `sys_units` VALUES (2, 'dokumen');
INSERT INTO `sys_units` VALUES (3, 'kegiatan');
INSERT INTO `sys_units` VALUES (5, 'peserta');

-- ----------------------------
-- Table structure for sys_users
-- ----------------------------
DROP TABLE IF EXISTS `sys_users`;
CREATE TABLE `sys_users`  (
  `su_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `su_no` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `su_sr_id` bigint(20) NULL DEFAULT NULL,
  `su_email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `su_passwd` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `su_fullname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `su_phone` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `su_avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `su_access_token` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `su_invite_token` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `su_recover_token` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `su_device_token` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `su_sex` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `su_pob` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `su_dob` date NULL DEFAULT NULL,
  `su_scp_id` int(11) NULL DEFAULT NULL,
  `su_sdp_id` int(11) NULL DEFAULT NULL,
  `su_sg_id` int(11) NULL DEFAULT NULL,
  `su_sj_id` int(11) NULL DEFAULT NULL,
  `su_active` int(11) NULL DEFAULT 0,
  `su_incognito` int(1) NULL DEFAULT 0,
  `su_task_due` date NULL DEFAULT NULL,
  `su_task_project` bigint(20) NULL DEFAULT NULL,
  `su_task_flag` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `su_created_dt` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP,
  `su_created_by` int(11) NULL DEFAULT NULL,
  `su_updated_dt` datetime(0) NULL DEFAULT NULL,
  `su_updated_by` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`su_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_users
-- ----------------------------
INSERT INTO `sys_users` VALUES (1, '198503302003121001', 4, 'admin@pusdikadm.xyz', '$2y$08$T2h2cWZaU0lIWUpoMFBKSuwWvsjYotQZm5i7AJntaEAOZ2cymi/iu', 'Administrator', '0812981728377', 'Miniclip-8-Ball-Pool-Avatar-15-180x180.png', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MjQ3ODEyOTEsImp0aSI6IjR5UDRIN3phMkFPVFVuNTQ3Z1BIaU5yK1wvclpCM0thWWU1b3BveFIrbVd3PSIsImlzcyI6IlBVU0RJS0FETSIsIm5iZiI6MTUyNDc4MTI5MiwiZXhwIjoxNTI0ODY1MjkyLCJkYXRhIjp7InN1X2VtYWlsIjoiYWRtaW5AcHVzZGlrYWRtLnh5eiIsInN1X3NyX2lkIjoiNCJ9fQ.vSF2op4Rajvx4bYzb2DKRtHn1BuZIVwRdvT4IlfNFeQ6JnG6-rAtENyFpUvvHm-rqma4U24Jyslav_exGDJXrg', NULL, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MTU2MjQ1NjgsImp0aSI6ImlJbE1VOXdaUGpmd2ZUbk9hMkdUK0oyQlVNTDZCa09oSkx1VFpJa2pCZVU9IiwiaXNzIjoiS3JlYXNpbmRvIENpcHRhIFRla25vbG9naSIsIm5iZiI6MTUxNTYyNDU2OSwiZXhwIjoxNTE1NzA4NTY5LCJkYXRhIjp7InN1X2VtYWlsIjoicm9zb0BrY3QuY28uaWQifX0.o1iI7ZWpATPgALV2P6Frdv09XcMnuIAWd6lImKyZqQN6Y5xp-_JhHC1nxDppVMEUs9qIBOFc8KNHHpBiYM-KZw', NULL, 'Laki-laki', 'Banyumas', '1985-07-03', 1, 1, 11, 1, 1, 0, NULL, NULL, 'DONE', '2017-04-27 20:52:36', NULL, NULL, NULL);
INSERT INTO `sys_users` VALUES (2, '198503302003121002', 7, 'eselon4@pusdikadm.xyz', '$2y$08$UWRzU3lrK0NFekprSWdpVelnCWtgEvCMORxnS3kSjUEGzBxxBx1lK', 'Pejabat E4', NULL, 'default-avatar-male_12.png', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MTY4NDQwMDcsImp0aSI6InNcL0ZObWJWS3dnXC9kVU4rcnNrNlhFMnRzcVl2S3I1OWkrVWhQckl3V1ErOD0iLCJpc3MiOiJLcmVhc2luZG8gQ2lwdGEgVGVrbm9sb2dpIiwibmJmIjoxNTE2ODQ0MDA4LCJleHAiOjE1MTY5MjgwMDgsImRhdGEiOnsic3VfZW1haWwiOiJ2aWRpQGtjdC5jby5pZCIsInN1X3NyX2lkIjoiNyJ9fQ.izKMm0aLfoJoRkKNrjNLjTxix73U_k8wUCBlgvARVCDHKYvde6vSb07fSMV60GP-Y7_FRfLWhAp0ukHgv_kVIg', NULL, NULL, NULL, 'Female', 'Cilacap', '2018-03-12', 1, 1, 11, 2, 1, 0, NULL, NULL, 'DONE', '2017-05-04 05:55:15', NULL, NULL, NULL);
INSERT INTO `sys_users` VALUES (3, '198503302003121003', 16, 'eselon3@pusdikadm.xyz', '$2y$08$NkpiM3VlR3JlNFZqU2hsceEVsA410evwpUesAl.GKYGKxfehDXEWW', 'Pejabat E3', NULL, 'eselon3_pusdikadm_xyz.png', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MjQ3NzUwODksImp0aSI6IlI1cTlDOGo1UWdRSGplMytNYzRFbEduUUpjZU9YMXVGYThEamNcL2doWG4wPSIsImlzcyI6IlBVU0RJS0FETSIsIm5iZiI6MTUyNDc3NTA5MCwiZXhwIjoxNTI0ODU5MDkwLCJkYXRhIjp7InN1X2VtYWlsIjoiZXNlbG9uM0BwdXNkaWthZG0ueHl6Iiwic3Vfc3JfaWQiOiIxNiJ9fQ.uCzNlRDs2qmSDMwBIAS8HnItwwHF6TujbD0aHkHqA0BzSN0z2dQgTzhIENXtC5cmgF0gHn_8h8t4xzrW_ul-iA', NULL, NULL, NULL, 'Male', NULL, NULL, 1, 1, 11, 3, 1, 0, NULL, NULL, 'DONE', '2017-05-04 06:24:39', NULL, NULL, NULL);
INSERT INTO `sys_users` VALUES (4, '198503302003121004', 16, 'kapus@pusdikadm.xyz', '$2y$08$R25qRXFZQUlZYXBKR0JpeOqrd5lLB0WKsdZBzvv.1dfe9qmXm9OdK', 'Pejabat Kapus', NULL, 'kapus_pusdikadm_xyz.png', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MjQ3NDI0MzEsImp0aSI6ImJxU1RHdkI3OGVIRkZoR2RPZWJwbFZYaTJsb2tya3N4cG1WQythUEs2YW89IiwiaXNzIjoiUFVTRElLQURNIiwibmJmIjoxNTI0NzQyNDMyLCJleHAiOjE1MjQ4MjY0MzIsImRhdGEiOnsic3VfZW1haWwiOiJrYXB1c0BwdXNkaWthZG0ueHl6Iiwic3Vfc3JfaWQiOiIxNiJ9fQ.vYEAXsZidMHmYiMBchbH2o5J72FWPQFOGmXO4Qnt4JiLD7LNqijjydVltFiGxTLvd0L7czbORVq8UuiY6RNn4w', NULL, NULL, NULL, 'Female', 'Jakarta', '2018-03-19', 1, 1, 17, 4, 1, 0, NULL, NULL, 'DONE', '2017-05-04 07:20:15', NULL, NULL, NULL);
INSERT INTO `sys_users` VALUES (16, '198503302003121005', 20, 'operator@pusdikadm.xyz', '$2y$08$Y0hZVHJCR2xjWlpHZHlnMuyL5k7KZHUSyvXZV9mzcGjpReuqbkW1S', 'Operator', '0812891288818', 'operator_pusdikadm_xyz.png', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MjQ3NzUzNjcsImp0aSI6IkJYeXlWajF6U1ExMmg4T0p5RUlZeUM5OGZaNDBEdXNubWNiVEM5MGNoTDA9IiwiaXNzIjoiUFVTRElLQURNIiwibmJmIjoxNTI0Nzc1MzY4LCJleHAiOjE1MjQ4NTkzNjgsImRhdGEiOnsic3VfZW1haWwiOiJvcGVyYXRvckBwdXNkaWthZG0ueHl6Iiwic3Vfc3JfaWQiOiIyMCJ9fQ.G_rrccBirjHw6x_FfaHuTA7acTtGch1iGQVAf3jxL7beIVxQPfOMLxQOPApom_QCN2YczZYxBjVxJ7TfAypKcA', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MTQ0OTY1MDEsImp0aSI6IktTeVpnckMrRnpxXC9veE1CblpVNE9LbU02VlJZMEJQblpHMGZOeUVqVDY4PSIsImlzcyI6IktyZWFzaW5kbyBDaXB0YSBUZWtub2xvZ2kiLCJuYmYiOjE1MTQ0OTY1MDIsImV4cCI6MTUxNDU4MDUwMiwiZGF0YSI6eyJzdV9lbWFpbCI6Im51cmZhcmlkODkyNEBnbWFpbC5jb20ifX0.nMDmk6apzl5ukFF2gdXQbnXfa8i3rB3r5YmmfI3A4V28RwRypbrYIczaI8eO1ZqWQsZOrnhPyvqYBkH7ZxP99w', NULL, NULL, 'Perempuan', 'Banyumas', '2018-04-23', 1, 1, 11, 7, 1, 0, NULL, NULL, 'DONE', '2017-12-29 04:28:21', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for sys_users_kanban
-- ----------------------------
DROP TABLE IF EXISTS `sys_users_kanban`;
CREATE TABLE `sys_users_kanban`  (
  `suk_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `suk_su_id` bigint(20) NULL DEFAULT NULL,
  `suk_ks_id` bigint(20) NULL DEFAULT NULL,
  `suk_selected` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`suk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sys_users_menus
-- ----------------------------
DROP TABLE IF EXISTS `sys_users_menus`;
CREATE TABLE `sys_users_menus`  (
  `sum_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sum_su_id` bigint(20) NULL DEFAULT NULL,
  `sum_smn_id` bigint(20) NULL DEFAULT NULL,
  `sum_selected` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`sum_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sys_users_panels
-- ----------------------------
DROP TABLE IF EXISTS `sys_users_panels`;
CREATE TABLE `sys_users_panels`  (
  `sus_id` int(11) NOT NULL AUTO_INCREMENT,
  `sus_sp_id` int(11) NULL DEFAULT NULL,
  `sus_su_id` int(11) NULL DEFAULT NULL,
  `sus_kp_id` int(11) NULL DEFAULT NULL,
  `sus_kst_id` int(11) NULL DEFAULT NULL,
  `sus_checked` int(1) NULL DEFAULT 0,
  PRIMARY KEY (`sus_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_users_panels
-- ----------------------------
INSERT INTO `sys_users_panels` VALUES (31, 37, 1, 80, 86, 1);
INSERT INTO `sys_users_panels` VALUES (32, 37, 1, 80, 87, 1);
INSERT INTO `sys_users_panels` VALUES (33, 37, 1, 80, 88, 0);
INSERT INTO `sys_users_panels` VALUES (34, 37, 1, 80, 89, 0);
INSERT INTO `sys_users_panels` VALUES (35, 37, 1, 80, 90, 0);
INSERT INTO `sys_users_panels` VALUES (36, 37, 1, 81, 91, 1);
INSERT INTO `sys_users_panels` VALUES (37, 37, 1, 82, 92, 0);
INSERT INTO `sys_users_panels` VALUES (38, 37, 1, 83, 93, 0);
INSERT INTO `sys_users_panels` VALUES (39, 37, 1, 84, 94, 0);
INSERT INTO `sys_users_panels` VALUES (40, 37, 1, 85, 95, 0);
INSERT INTO `sys_users_panels` VALUES (41, 37, 1, 86, 96, 0);
INSERT INTO `sys_users_panels` VALUES (42, 37, 1, 87, 97, 0);

-- ----------------------------
-- Table structure for sys_users_permissions
-- ----------------------------
DROP TABLE IF EXISTS `sys_users_permissions`;
CREATE TABLE `sys_users_permissions`  (
  `sup_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sup_su_id` bigint(20) NULL DEFAULT NULL,
  `sup_smc_id` bigint(20) NULL DEFAULT NULL,
  `sup_selected` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`sup_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sys_users_tokens
-- ----------------------------
DROP TABLE IF EXISTS `sys_users_tokens`;
CREATE TABLE `sys_users_tokens`  (
  `sut_id` int(11) NOT NULL AUTO_INCREMENT,
  `sut_su_id` int(11) NULL DEFAULT NULL,
  `sut_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sut_topic` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sut_token` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `sut_created` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`sut_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_users_tokens
-- ----------------------------
INSERT INTO `sys_users_tokens` VALUES (5, 1, 'gcm', 'chrome', 'fnCgvheJa7k:APA91bGfmeJUeFzQrWlsyoi7u0-KM6v9OHMcDFukYiqUF86sGjWdayfEYUo5Fz211rgS308Z0iMMHrsChIqQRzxKehhfcxd8jD3wA9Jm8mZXF38U0S7UP2XdSvEToXX08D0_8Bqb1j8j', '2018-04-16 14:38:18');
INSERT INTO `sys_users_tokens` VALUES (6, 4, 'gcm', 'chrome', 'cBXHxm2mXBA:APA91bGOF8-Og71OH4KI8pLY_Pv0SCpWXRERFZHvzAJzULkRR7g3uCDT4sP9YSolwoB-ufAGRCD67CUxTNo0IqDX4MFf_ZX4yKHid0JXMJx-wwNtl03G9ZvY0AD7orjuUjV0KQIAZyAj', '2018-04-25 19:47:22');
INSERT INTO `sys_users_tokens` VALUES (7, 1, 'gcm', 'chrome', 'djSVH2j6Wqs:APA91bGMJtgF4GAb7uAfEheKLIKNmHy0vjZeTKnYd5vUEfsZtZGBLIVRswj2QGrZv4Zlw0hL9dzySgyMjjfGeQtmqKOPY-FmaGBcXL7oO5tHiqxGGvFZ8U8wc_LGuA_nCgvOf6hTpMRA', '2018-04-27 05:21:39');

-- ----------------------------
-- Table structure for trx_items
-- ----------------------------
DROP TABLE IF EXISTS `trx_items`;
CREATE TABLE `trx_items`  (
  `ti_id` int(11) NOT NULL AUTO_INCREMENT,
  `ti_desc` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ti_user` int(11) NULL DEFAULT NULL,
  `ti_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'lkh',
  PRIMARY KEY (`ti_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for trx_lkh
-- ----------------------------
DROP TABLE IF EXISTS `trx_lkh`;
CREATE TABLE `trx_lkh`  (
  `lkh_id` int(11) NOT NULL AUTO_INCREMENT,
  `lkh_period` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `lkh_su_id` int(11) NULL DEFAULT NULL,
  `lkh_start_date` date NULL DEFAULT NULL,
  `lkh_end_date` date NULL DEFAULT NULL,
  `lkh_evaluator` int(11) NULL DEFAULT NULL,
  `lkh_examiner` int(11) NULL DEFAULT NULL,
  `lkh_task_project` int(11) NULL DEFAULT NULL,
  `lkh_task_due` date NULL DEFAULT NULL,
  `lkh_created_dt` datetime(0) NULL DEFAULT NULL,
  `lkh_created_by` int(11) NULL DEFAULT NULL,
  `lkh_updated_dt` datetime(0) NULL DEFAULT NULL,
  `lkh_updated_by` int(11) NULL DEFAULT NULL,
  `lkh_flag` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`lkh_id`) USING BTREE,
  INDEX `lkh_idx_0`(`lkh_task_project`) USING BTREE,
  INDEX `lkh_idx_1`(`lkh_su_id`) USING BTREE,
  INDEX `lkh_idx_2`(`lkh_start_date`, `lkh_end_date`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for trx_lkh_days
-- ----------------------------
DROP TABLE IF EXISTS `trx_lkh_days`;
CREATE TABLE `trx_lkh_days`  (
  `lkd_id` int(11) NOT NULL AUTO_INCREMENT,
  `lkd_tpr_id` int(11) NULL DEFAULT NULL,
  `lkd_lkh_id` int(11) NULL DEFAULT NULL,
  `lkd_date` date NULL DEFAULT NULL,
  `lkd_logs` int(1) NULL DEFAULT 0,
  `lkd_created_dt` datetime(0) NULL DEFAULT NULL,
  `lkd_created_by` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`lkd_id`) USING BTREE,
  INDEX `lkd_idx_0`(`lkd_lkh_id`) USING BTREE,
  INDEX `lkd_idx_1`(`lkd_date`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for trx_lkh_exams
-- ----------------------------
DROP TABLE IF EXISTS `trx_lkh_exams`;
CREATE TABLE `trx_lkh_exams`  (
  `lke_id` int(11) NOT NULL AUTO_INCREMENT,
  `lke_lkh_id` int(11) NULL DEFAULT NULL,
  `lke_examiner` int(11) NULL DEFAULT NULL,
  `lke_date` date NULL DEFAULT NULL,
  `lke_flag` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `lke_notes` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`lke_id`) USING BTREE,
  INDEX `lke_idx_0`(`lke_lkh_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for trx_lkh_files
-- ----------------------------
DROP TABLE IF EXISTS `trx_lkh_files`;
CREATE TABLE `trx_lkh_files`  (
  `lkf_id` int(11) NOT NULL AUTO_INCREMENT,
  `lkf_lki_id` int(11) NULL DEFAULT NULL,
  `lkf_file` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `lkf_orig` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `lkf_mime` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `lkf_size` double(15, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`lkf_id`) USING BTREE,
  INDEX `lkf_idx_0`(`lkf_lki_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for trx_lkh_items
-- ----------------------------
DROP TABLE IF EXISTS `trx_lkh_items`;
CREATE TABLE `trx_lkh_items`  (
  `lki_id` int(11) NOT NULL AUTO_INCREMENT,
  `lki_lkd_id` int(11) NULL DEFAULT NULL,
  `lki_date` date NULL DEFAULT NULL,
  `lki_desc` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `lki_ti_id` int(11) NULL DEFAULT NULL,
  `lki_volume` int(11) NULL DEFAULT NULL,
  `lki_unit` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `lki_cost` double(15, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`lki_id`) USING BTREE,
  INDEX `lki_idx_0`(`lki_lkd_id`, `lki_ti_id`) USING BTREE,
  INDEX `lki_idx_1`(`lki_unit`, `lki_lkd_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for trx_lkh_labels
-- ----------------------------
DROP TABLE IF EXISTS `trx_lkh_labels`;
CREATE TABLE `trx_lkh_labels`  (
  `lkl_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `lkl_lkh_id` bigint(20) NULL DEFAULT NULL,
  `lkl_sl_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`lkl_id`) USING BTREE,
  INDEX `lkl_idx_0`(`lkl_lkh_id`, `lkl_sl_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for trx_lkh_statuses
-- ----------------------------
DROP TABLE IF EXISTS `trx_lkh_statuses`;
CREATE TABLE `trx_lkh_statuses`  (
  `lks_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `lks_lkh_id` bigint(20) NULL DEFAULT NULL,
  `lks_status` bigint(20) NULL DEFAULT NULL,
  `lks_target` bigint(20) NULL DEFAULT NULL,
  `lks_worker` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `lks_deleted` int(11) NULL DEFAULT NULL,
  `lks_created` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`lks_id`) USING BTREE,
  INDEX `lks_idx_0`(`lks_lkh_id`, `lks_status`) USING BTREE,
  INDEX `lks_idx_1`(`lks_status`, `lks_deleted`, `lks_created`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for trx_lkh_tasks
-- ----------------------------
DROP TABLE IF EXISTS `trx_lkh_tasks`;
CREATE TABLE `trx_lkh_tasks`  (
  `tlt_id` int(11) NOT NULL,
  `tlt_su_id` int(11) NULL DEFAULT NULL,
  `tlt_start_date` date NULL DEFAULT NULL,
  `tlt_end_date` date NULL DEFAULT NULL,
  `tlt_examiner` int(11) NULL DEFAULT NULL,
  `tlt_superior` int(11) NULL DEFAULT NULL,
  `tlt_task_project` int(11) NULL DEFAULT NULL,
  `tlt_task_due` date NULL DEFAULT NULL,
  `tlt_created_dt` datetime(0) NULL DEFAULT NULL,
  `tlt_created_by` int(11) NULL DEFAULT NULL,
  `tlt_updated_dt` datetime(0) NULL DEFAULT NULL,
  `tlt_updated_by` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`tlt_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for trx_lkh_users
-- ----------------------------
DROP TABLE IF EXISTS `trx_lkh_users`;
CREATE TABLE `trx_lkh_users`  (
  `lku_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `lku_lkh_id` bigint(20) NULL DEFAULT NULL,
  `lku_su_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`lku_id`) USING BTREE,
  INDEX `lku_idx_0`(`lku_lkh_id`, `lku_su_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for trx_presence
-- ----------------------------
DROP TABLE IF EXISTS `trx_presence`;
CREATE TABLE `trx_presence`  (
  `tpr_id` int(11) NOT NULL AUTO_INCREMENT,
  `tpr_date` date NULL DEFAULT NULL,
  `tpr_su_id` int(11) NULL DEFAULT NULL,
  `tpr_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tpr_checkin` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tpr_checkout` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tpr_filename` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tpr_filetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tpr_desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tpr_task_project` int(255) NULL DEFAULT NULL,
  `tpr_task_due` date NULL DEFAULT NULL,
  `tpr_created_dt` datetime(0) NULL DEFAULT NULL,
  `tpr_created_by` int(255) NULL DEFAULT NULL,
  `tpr_updated_dt` datetime(0) NULL DEFAULT NULL,
  `tpr_updated_by` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`tpr_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for trx_presence_labels
-- ----------------------------
DROP TABLE IF EXISTS `trx_presence_labels`;
CREATE TABLE `trx_presence_labels`  (
  `tpl_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tpl_tpr_id` bigint(20) NULL DEFAULT NULL,
  `tpl_sl_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`tpl_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for trx_presence_statuses
-- ----------------------------
DROP TABLE IF EXISTS `trx_presence_statuses`;
CREATE TABLE `trx_presence_statuses`  (
  `tps_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tps_tpr_id` bigint(20) NULL DEFAULT NULL,
  `tps_status` bigint(20) NULL DEFAULT NULL,
  `tps_target` bigint(20) NULL DEFAULT NULL,
  `tps_worker` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tps_deleted` int(11) NULL DEFAULT NULL,
  `tps_created` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`tps_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for trx_presence_types
-- ----------------------------
DROP TABLE IF EXISTS `trx_presence_types`;
CREATE TABLE `trx_presence_types`  (
  `tpt_id` int(11) NOT NULL AUTO_INCREMENT,
  `tpt_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tpt_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for trx_skp
-- ----------------------------
DROP TABLE IF EXISTS `trx_skp`;
CREATE TABLE `trx_skp`  (
  `skp_id` int(11) NOT NULL AUTO_INCREMENT,
  `skp_period` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `skp_start_date` date NULL DEFAULT NULL,
  `skp_end_date` date NULL DEFAULT NULL,
  `skp_su_id` int(11) NULL DEFAULT NULL,
  `skp_task_project` int(255) NULL DEFAULT NULL,
  `skp_task_due` date NULL DEFAULT NULL,
  `skp_task_flag` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `skp_examiner` int(11) NULL DEFAULT NULL,
  `skp_evaluator` int(11) NULL DEFAULT NULL,
  `skp_performance` double(15, 2) NULL DEFAULT NULL,
  `skp_performance_criteria` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `skp_performance_value` double(15, 2) NULL DEFAULT NULL,
  `skp_behavior_total` double(15, 2) NULL DEFAULT NULL,
  `skp_behavior_average` double(15, 2) NULL DEFAULT NULL,
  `skp_behavior_criteria` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `skp_behavior_value` double(15, 2) NULL DEFAULT NULL,
  `skp_value` double(15, 2) NULL DEFAULT NULL,
  `skp_criteria` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `skp_cover_header_1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `skp_cover_header_2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `skp_cover_footer_1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `skp_cover_footer_2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `skp_objection` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `skp_objection_dt` date NULL DEFAULT NULL,
  `skp_response` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `skp_response_dt` date NULL DEFAULT NULL,
  `skp_resolution` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `skp_resolution_dt` date NULL DEFAULT NULL,
  `skp_recommendation` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `skp_report_addr` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `skp_report_dt` date NULL DEFAULT NULL,
  `skp_receive_dt` date NULL DEFAULT NULL,
  `skp_warn` int(1) NULL DEFAULT 0,
  `skp_disposition_dt` date NULL DEFAULT NULL,
  `skp_created_dt` datetime(0) NULL DEFAULT NULL,
  `skp_created_by` int(11) NULL DEFAULT NULL,
  `skp_updated_dt` datetime(0) NULL DEFAULT NULL,
  `skp_updated_by` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`skp_id`) USING BTREE,
  INDEX `skp_idx_0`(`skp_task_project`, `skp_created_dt`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for trx_skp_behaviors
-- ----------------------------
DROP TABLE IF EXISTS `trx_skp_behaviors`;
CREATE TABLE `trx_skp_behaviors`  (
  `tsb_id` int(11) NOT NULL AUTO_INCREMENT,
  `tsb_skp_id` int(11) NULL DEFAULT NULL,
  `tsb_tbh_id` int(11) NULL DEFAULT NULL,
  `tsb_value` double(15, 2) NULL DEFAULT NULL,
  `tsb_criteria` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tsb_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for trx_skp_exams
-- ----------------------------
DROP TABLE IF EXISTS `trx_skp_exams`;
CREATE TABLE `trx_skp_exams`  (
  `ske_id` int(11) NOT NULL AUTO_INCREMENT,
  `ske_skp_id` int(11) NULL DEFAULT NULL,
  `ske_examiner` int(11) NULL DEFAULT NULL,
  `ske_date` date NULL DEFAULT NULL,
  `ske_flag` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ske_notes` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ske_id`) USING BTREE,
  INDEX `lke_idx_0`(`ske_skp_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for trx_skp_items
-- ----------------------------
DROP TABLE IF EXISTS `trx_skp_items`;
CREATE TABLE `trx_skp_items`  (
  `ski_id` int(11) NOT NULL AUTO_INCREMENT,
  `ski_skp_id` int(11) NULL DEFAULT NULL,
  `ski_date` date NULL DEFAULT NULL,
  `ski_desc` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ski_volume` double(15, 2) NULL DEFAULT NULL,
  `ski_volume_real` double(15, 2) NULL DEFAULT NULL,
  `ski_unit` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ski_cost` double(15, 2) NULL DEFAULT NULL,
  `ski_cost_real` double(15, 2) NULL DEFAULT NULL,
  `ski_duration` double(15, 2) NULL DEFAULT NULL,
  `ski_duration_real` double(15, 2) NULL DEFAULT NULL,
  `ski_duration_unit` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ski_quality` double(15, 2) NULL DEFAULT NULL,
  `ski_quality_real` double(15, 2) NULL DEFAULT NULL,
  `ski_ak` double(15, 2) NULL DEFAULT NULL,
  `ski_ak_real` double(15, 2) NULL DEFAULT NULL,
  `ski_ak_factor` double(15, 2) NULL DEFAULT NULL,
  `ski_extra` int(1) NULL DEFAULT 0,
  `ski_total` double(15, 2) NULL DEFAULT NULL,
  `ski_performance` double(15, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`ski_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for trx_skp_labels
-- ----------------------------
DROP TABLE IF EXISTS `trx_skp_labels`;
CREATE TABLE `trx_skp_labels`  (
  `skl_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `skl_skp_id` bigint(20) NULL DEFAULT NULL,
  `skl_sl_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`skl_id`) USING BTREE,
  INDEX `skl_idx_0`(`skl_skp_id`, `skl_sl_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for trx_skp_statuses
-- ----------------------------
DROP TABLE IF EXISTS `trx_skp_statuses`;
CREATE TABLE `trx_skp_statuses`  (
  `sks_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sks_skp_id` bigint(20) NULL DEFAULT NULL,
  `sks_status` bigint(20) NULL DEFAULT NULL,
  `sks_target` bigint(20) NULL DEFAULT NULL,
  `sks_worker` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sks_deleted` int(11) NULL DEFAULT NULL,
  `sks_created` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`sks_id`) USING BTREE,
  INDEX `sks_idx_0`(`sks_skp_id`, `sks_status`) USING BTREE,
  INDEX `sks_idx_1`(`sks_status`, `sks_deleted`, `sks_created`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for trx_skp_users
-- ----------------------------
DROP TABLE IF EXISTS `trx_skp_users`;
CREATE TABLE `trx_skp_users`  (
  `sku_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sku_skp_id` bigint(20) NULL DEFAULT NULL,
  `sku_su_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`sku_id`) USING BTREE,
  INDEX `sku_idx_0`(`sku_skp_id`, `sku_su_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for trx_surat_masuk
-- ----------------------------
DROP TABLE IF EXISTS `trx_surat_masuk`;
CREATE TABLE `trx_surat_masuk`  (
  `tsm_id` int(11) NOT NULL AUTO_INCREMENT,
  `tsm_seq` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tsm_reg_date` date NULL DEFAULT NULL,
  `tsm_reg_user` int(255) NULL DEFAULT NULL,
  `tsm_reg_no` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tsm_tcs_id` int(11) NULL DEFAULT NULL,
  `tsm_no` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tsm_date` date NULL DEFAULT NULL,
  `tsm_subject` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tsm_summary` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `tsm_from` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tsm_to` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tsm_admin` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tsm_flag` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tsm_tsk_id` int(11) NULL DEFAULT NULL,
  `tsm_task_project` int(11) NULL DEFAULT NULL,
  `tsm_task_due` date NULL DEFAULT NULL,
  `tsm_created_by` int(11) NULL DEFAULT NULL,
  `tsm_created_dt` datetime(0) NULL DEFAULT NULL,
  `tsm_updated_by` int(11) NULL DEFAULT NULL,
  `tsm_updated_dt` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`tsm_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_surat_masuk
-- ----------------------------
INSERT INTO `trx_surat_masuk` VALUES (1, '00040', '2018-02-17', 1, '00040 / 040 / 212 / 2018', 4, '15678 / A - 040 / 314 / 2018', '2018-02-17', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod\r\ntempor incididunt ut labore et dolore magna aliqua.', NULL, 'Kementerian Dalam Negeri', 'Kepala Pusdiklat Tenaga Administrasi', 'Bagian Umum', 'ARCHIVED', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `trx_surat_masuk` VALUES (2, '00041', '2018-02-17', 1, '00041 / A - 040 / 212 / 2018', 4, '15627 / A - 040 / 314 / 2018', '2018-02-17', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod\r\ntempor incididunt ut labore et dolore magna aliqua.', NULL, 'Kementerian Dalam Negeri', 'Kepala Pusdiklat Tenaga Administrasi', 'Bagian Umum', 'REPLY', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `trx_surat_masuk` VALUES (3, '00044', '2018-02-17', 1, '15620 / A - 040 / 314 / 2018', 2, '15620 / A - 040 / 314 / 2018', '2018-02-17', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod\r\ntempor incididunt ut labore et dolore magna aliqua.', NULL, 'Kementerian Dalam Negeri', 'Kepala Pusdiklat Tenaga Administrasi', 'Bagian Umum', 'REPLY', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `trx_surat_masuk` VALUES (4, '00045', '2018-02-17', 1, 'A', 1, 'A', '2018-02-17', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod\r\ntempor incididunt ut labore et dolore magna aliqua.', NULL, 'Kementerian Dalam Negeri', 'Kepala Pusdiklat Tenaga Administrasi', 'Bagian Umum', 'ARCHIVED', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `trx_surat_masuk` VALUES (5, NULL, '2018-02-18', 1, NULL, 6, 'ABC', '2018-02-17', 'Pengawasan', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'Kementerian Dalam Negeri', 'Kepala Pusdiklat Tenaga Administrasi', 'Bagian Umum', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `trx_surat_masuk` VALUES (6, '00046', '2018-02-18', 1, '00046/040-PDM/II/2018', 4, '002/800-SMKN.5/VII/2017', '2018-02-18', 'Undangan', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'Kementerian Dalam Negeri', 'Kepala Pusdiklat Tenaga Administrasi', 'Bagian Umum', 'ARCHIVED', 1, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for trx_tasks
-- ----------------------------
DROP TABLE IF EXISTS `trx_tasks`;
CREATE TABLE `trx_tasks`  (
  `tt_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tt_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tt_flag` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tt_sp_id` bigint(20) NULL DEFAULT NULL,
  `tt_desc` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `tt_due_date` date NULL DEFAULT NULL,
  `tt_creator_id` bigint(20) NULL DEFAULT NULL,
  `tt_created_dt` datetime(0) NULL DEFAULT NULL,
  `tt_updated_dt` datetime(0) NULL DEFAULT NULL,
  `tt_updater_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`tt_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for trx_tasks_activities
-- ----------------------------
DROP TABLE IF EXISTS `trx_tasks_activities`;
CREATE TABLE `trx_tasks_activities`  (
  `tta_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tta_tt_id` bigint(20) NULL DEFAULT NULL,
  `tta_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tta_sender` bigint(20) NULL DEFAULT NULL,
  `tta_created` datetime(0) NULL DEFAULT NULL,
  `tta_data` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `tta_file` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tta_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for trx_tasks_labels
-- ----------------------------
DROP TABLE IF EXISTS `trx_tasks_labels`;
CREATE TABLE `trx_tasks_labels`  (
  `ttl_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ttl_tt_id` bigint(20) NULL DEFAULT NULL,
  `ttl_sl_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`ttl_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for trx_tasks_statuses
-- ----------------------------
DROP TABLE IF EXISTS `trx_tasks_statuses`;
CREATE TABLE `trx_tasks_statuses`  (
  `tts_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tts_tt_id` bigint(20) NULL DEFAULT NULL,
  `tts_status` bigint(20) NULL DEFAULT NULL,
  `tts_target` bigint(20) NULL DEFAULT NULL,
  `tts_worker` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tts_data_id` int(11) NULL DEFAULT NULL,
  `tts_result` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `tts_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `tts_deleted` int(11) NULL DEFAULT NULL,
  `tts_created` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`tts_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for trx_tasks_users_copy
-- ----------------------------
DROP TABLE IF EXISTS `trx_tasks_users_copy`;
CREATE TABLE `trx_tasks_users_copy`  (
  `ttu_tt_id` bigint(20) NULL DEFAULT NULL,
  `ttu_su_id` bigint(20) NULL DEFAULT NULL,
  `ttu_id` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ttu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for trx_users_labels
-- ----------------------------
DROP TABLE IF EXISTS `trx_users_labels`;
CREATE TABLE `trx_users_labels`  (
  `tul_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tul_su_id` bigint(20) NULL DEFAULT NULL,
  `tul_sl_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`tul_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for trx_users_statuses
-- ----------------------------
DROP TABLE IF EXISTS `trx_users_statuses`;
CREATE TABLE `trx_users_statuses`  (
  `tus_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tus_su_id` bigint(20) NULL DEFAULT NULL,
  `tus_status` bigint(20) NULL DEFAULT NULL,
  `tus_target` bigint(20) NULL DEFAULT NULL,
  `tus_worker` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tus_deleted` int(11) NULL DEFAULT NULL,
  `tus_created` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`tus_id`) USING BTREE,
  INDEX `tus_idx_0`(`tus_su_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for trx_users_users
-- ----------------------------
DROP TABLE IF EXISTS `trx_users_users`;
CREATE TABLE `trx_users_users`  (
  `tru_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tru_task` bigint(20) NULL DEFAULT NULL,
  `tru_user` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`tru_id`) USING BTREE,
  INDEX `lku_idx_0`(`tru_task`, `tru_user`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;
