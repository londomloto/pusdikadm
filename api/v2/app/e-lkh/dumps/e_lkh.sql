/*
 Navicat Premium Data Transfer

 Source Server         : mysql@127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 50626
 Source Host           : 127.0.0.1:3306
 Source Schema         : e_lkh

 Target Server Type    : MySQL
 Target Server Version : 50626
 File Encoding         : 65001

 Date: 21/04/2018 19:12:57
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
) ENGINE = InnoDB AUTO_INCREMENT = 69 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of bpm_diagrams
-- ----------------------------
INSERT INTO `bpm_diagrams` VALUES (62, 'Graph.diagram.type.Activity', 'Proses Pendaftaran', 'proses-pendaftaran', 'Bisnis proses pendaftaran peserta', 'af621858317b34656e92cecd86909ee6.jpg', '2018-01-24 06:55:32', NULL);
INSERT INTO `bpm_diagrams` VALUES (64, 'Graph.diagram.type.Activity', 'Proses LKH', 'proses-lkh', 'Bisnis proses LKH', 'b843101c8b8256ee5c5b0743904b6a9a.jpg', '2018-01-25 04:03:32', NULL);
INSERT INTO `bpm_diagrams` VALUES (65, 'Graph.diagram.type.Activity', 'Proses SKP', 'proses-skp', 'Bisnis proses dokumen SKP', '837ad659a5d9220a314b71c10182dc0e.jpg', '2018-01-25 04:05:59', NULL);
INSERT INTO `bpm_diagrams` VALUES (68, 'Graph.diagram.type.Activity', 'Proses Absensi', 'proses-absensi', 'Bisnis proses absensi', '1bd5a80db2abeeb5b43d35541e528c9d.jpg', '2018-03-05 03:11:21', NULL);

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
INSERT INTO `bpm_forms` VALUES (44, 896, 'Form Autentikasi', 'Form untuk melakukan autentikasi data peserta', '015a8212544a3d6e87be8ab297e2a96a.html', 'form-pendaftaran-auth.html');
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
INSERT INTO `bpm_forms` VALUES (79, 956, 'Form Penilaian', 'No description', '77f5c59cb361b22b2c04aad7e996b852.html', 'form-skp.html');
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
) ENGINE = InnoDB AUTO_INCREMENT = 796 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of bpm_links
-- ----------------------------
INSERT INTO `bpm_links` VALUES (704, 'tahap-pendaftaran', 'graph-link-1', 'graph-shape-1', 'graph-shape-2', 'Graph.link.Orthogonal', 'orthogonal', 62, 894, 895, 'M430.99999999999994,96.21874999999967L431,179.21875000000014', '#000', 'Tahap Pendaftaran', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (705, 'tahap-autentifikasi', 'graph-link-2', 'graph-shape-2', 'graph-shape-3', 'Graph.link.Orthogonal', 'orthogonal', 62, 895, 896, 'M431,239.21875000000009L431,318.2187499999991', '#000', 'Tahap Autentifikasi', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (706, 'tahap-konfirmasi', 'graph-link-3', 'graph-shape-3', 'graph-shape-4', 'Graph.link.Orthogonal', 'orthogonal', 62, 896, 897, 'M431.00000000000625,378.2187500000007L431.000000000003,454.21874999999847', '#000', 'Tahap Konfirmasi', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (708, 'peserta-terdaftar', 'graph-link-4', 'graph-shape-4', 'graph-shape-5', 'Graph.link.Orthogonal', 'orthogonal', 62, 897, 899, 'M431.15929203539395,514.2187500000003L431.15929203539395,626.2187499999992', '#000', 'Peserta Terdaftar', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (709, NULL, 'graph-link-5', 'graph-shape-5', 'graph-shape-6', 'Graph.link.Orthogonal', 'orthogonal', 62, 899, 900, 'M431,686.2187499999993L431,765.2187499999994', '#000', '', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (712, 'tahap-pembuatan', 'graph-link-1', 'graph-shape-1', 'graph-shape-2', 'Graph.link.Orthogonal', 'orthogonal', 65, 904, 905, 'M440.0000000000005,95.21875000000037L439.9999999999991,161.21874999999991', '#000', 'Tahap Pembuatan', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (759, 'tahap-pemeriksaan', 'graph-link-6', 'graph-shape-8', 'graph-shape-9', 'Graph.link.Orthogonal', 'orthogonal', 64, 938, 939, 'M451.0000000000018,253.21875000000026L450.9999999999989,357.21875000000034', '#000', 'Tahap Pemeriksaan', 0.5, 1, 0, 6, NULL, '[{\"field\":\"lkh_flag\",\"comparison\":\"=\",\"value\":\"EXAM\",\"operator\":\"\"}]');
INSERT INTO `bpm_links` VALUES (770, 'tahap-pemeriksaan', 'graph-link-2', 'graph-shape-2', 'graph-shape-4', 'Graph.link.Orthogonal', 'orthogonal', 65, 905, 947, 'M439.99999999999847,221.21875000000006L440.00000000000614,309.2187500000003', '#000', 'Tahap Pemeriksaan', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (780, 'tahap-pembuatan', 'graph-link-7', 'graph-shape-6', 'graph-shape-8', 'Graph.link.Orthogonal', 'orthogonal', 64, 907, 938, 'M451.00000000000006,95.21875000000044L450.9999999999993,193.21875000000006', '#000', 'Tahap Pembuatan', 0.5, 1, 0, 6, NULL, '[{\"field\":\"lkh_flag\",\"comparison\":\"=\",\"value\":\"TODO\",\"operator\":\"\"}]');
INSERT INTO `bpm_links` VALUES (781, 'tahap-absensi', 'graph-link-1', 'graph-shape-1', 'graph-shape-2', 'Graph.link.Orthogonal', 'orthogonal', 68, 950, 951, 'M417.00000000000006,87.21874999999939L417,167.21875000000017', '#000', 'Tahap Absensi', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (782, NULL, 'graph-link-2', 'graph-shape-2', 'graph-shape-3', 'Graph.link.Orthogonal', 'orthogonal', 68, 951, 952, 'M417.0000000000003,227.21874999999957L416.99999999999943,297.2187500000009', '#000', '', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (784, NULL, 'graph-link-8', 'graph-shape-10', 'graph-shape-7', 'Graph.link.Orthogonal', 'orthogonal', 64, 954, 909, 'M451,594.4053792823967L451.00000000000006,677.4053792823992', '#000', '', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (791, 'tahap-penilaian', 'graph-link-4', 'graph-shape-4', 'graph-shape-5', 'Graph.link.Orthogonal', 'orthogonal', 65, 947, 956, 'M440.00000000000716,369.21874999999966L439.9999999999989,458.51593636174897', '#000', 'Tahap Penilaian', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (792, 'tahap-pengesahan', 'graph-link-9', 'graph-shape-9', 'graph-shape-10', 'Graph.link.Orthogonal', 'orthogonal', 64, 939, 954, 'M451.00000000000546,417.2187500000013L451.00000000000284,534.4053792824009', '#000', 'Tahap Pengesahan', 0.5, 1, 0, 6, NULL, '[{\"field\":\"lkh_flag\",\"comparison\":\"=\",\"value\":\"DONE\",\"operator\":\"\"}]');
INSERT INTO `bpm_links` VALUES (793, NULL, 'graph-link-5', 'graph-shape-6', 'graph-shape-3', 'Graph.link.Orthogonal', 'orthogonal', 65, 957, 906, 'M440.00000000001114,664.218750000001L440.00000000000347,741.7346863617488', '#000', '', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (794, 'tahap-penerimaan', 'graph-link-6', 'graph-shape-5', 'graph-shape-6', 'Graph.link.Orthogonal', 'orthogonal', 65, 956, 957, 'M439.9999999999986,518.5159363617508L440.00000000001796,604.218750000002', '#000', 'Tahap Penerimaan', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (795, 'tahap-pembuatan', 'graph-link-10', 'graph-shape-9', 'graph-shape-8', 'Graph.link.Orthogonal', 'orthogonal', 64, 939, 938, 'M381,387.2187499999745L227.99999999999693,387.21875L227.99999999999693,223.21875L381,223.2187500000119', '#000', 'Tahap Pembuatan', 0.5, 1, 0, 6, NULL, '[{\"field\":\"lkh_flag\",\"comparison\":\"=\",\"value\":\"TODO\",\"operator\":\"\"}]');

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
) ENGINE = InnoDB AUTO_INCREMENT = 958 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of bpm_shapes
-- ----------------------------
INSERT INTO `bpm_shapes` VALUES (894, 'graph-shape-1', NULL, NULL, 'Graph.shape.activity.Start', NULL, 62, NULL, 60, 60, 401, 36.21875, 0, 'Start', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (895, 'graph-shape-2', NULL, NULL, 'Graph.shape.activity.Action', NULL, 62, NULL, 140, 60, 361, 179.21875, 0, 'Tahap Pendaftaran', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (896, 'graph-shape-3', NULL, NULL, 'Graph.shape.activity.Action', NULL, 62, NULL, 140, 60, 361, 318.21875, 0, 'Tahap Autentikasi', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (897, 'graph-shape-4', NULL, NULL, 'Graph.shape.activity.Action', NULL, 62, NULL, 140, 60, 361, 454.21875, 0, 'Tahap Konfirmasi', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (899, 'graph-shape-5', NULL, NULL, 'Graph.shape.activity.Action', NULL, 62, NULL, 140, 60, 361, 626.21875, 0, 'Peserta Terdaftar', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (900, 'graph-shape-6', NULL, NULL, 'Graph.shape.activity.Final', NULL, 62, NULL, 60, 60, 401, 765.21875, 0, 'End', '#FF4081', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (904, 'graph-shape-1', NULL, NULL, 'Graph.shape.activity.Start', NULL, 65, NULL, 60, 60, 410, 35.21875, 0, 'Start', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (905, 'graph-shape-2', NULL, NULL, 'Graph.shape.activity.Action', NULL, 65, NULL, 140, 60, 370, 161.21875, 0, 'Tahap Pembuatan', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (906, 'graph-shape-3', NULL, NULL, 'Graph.shape.activity.Final', NULL, 65, NULL, 60.179160620936, 60, 409.91041968954, 741.73468636175, 0, 'End', '#FF4081', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (907, 'graph-shape-6', NULL, NULL, 'Graph.shape.activity.Start', NULL, 64, NULL, 60, 60, 421, 35.21875, 0, 'Start', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (909, 'graph-shape-7', NULL, NULL, 'Graph.shape.activity.Final', NULL, 64, NULL, 60, 60, 421, 677.4053792824, 0, 'End', '#FF4081', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (938, 'graph-shape-8', NULL, NULL, 'Graph.shape.activity.Action', NULL, 64, NULL, 140, 60, 381, 193.21875, 0, 'Tahap Pembuatan', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (939, 'graph-shape-9', NULL, NULL, 'Graph.shape.activity.Action', NULL, 64, NULL, 140, 60, 381, 357.21875, 0, 'Tahap Pemeriksaan', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (947, 'graph-shape-4', NULL, NULL, 'Graph.shape.activity.Action', NULL, 65, NULL, 140, 60, 370, 309.21875, 0, 'Tahap Pemeriksaan', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (950, 'graph-shape-1', NULL, NULL, 'Graph.shape.activity.Start', NULL, 68, NULL, 60, 60, 387, 27.21875, 0, 'Start', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (951, 'graph-shape-2', NULL, NULL, 'Graph.shape.activity.Action', NULL, 68, NULL, 140, 60, 347, 167.21875, 0, 'Tahap Absensi', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (952, 'graph-shape-3', NULL, NULL, 'Graph.shape.activity.Final', NULL, 68, NULL, 60, 60, 387, 297.21875, 0, 'End', '#FF4081', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (954, 'graph-shape-10', NULL, NULL, 'Graph.shape.activity.Action', NULL, 64, NULL, 140, 60, 381, 534.4053792824, 0, 'Tahap Pengesahan', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (956, 'graph-shape-5', NULL, NULL, 'Graph.shape.activity.Action', NULL, 65, NULL, 140, 60, 370, 458.51593636175, 0, 'Tahap Penilaian', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (957, 'graph-shape-6', NULL, NULL, 'Graph.shape.activity.Action', NULL, 65, NULL, 140, 60, 370, 604.21875, 0, 'Tahap Penerimaan', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');

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
) ENGINE = InnoDB AUTO_INCREMENT = 122 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of kanban_panels
-- ----------------------------
INSERT INTO `kanban_panels` VALUES (88, 24, 'Tahap Pendaftaran', '#2196f3', 0);
INSERT INTO `kanban_panels` VALUES (89, 24, 'Tahap Autentifikasi', '#607d8b', 1);
INSERT INTO `kanban_panels` VALUES (90, 24, 'Tahap Konfirmasi', '#e91e63', 2);
INSERT INTO `kanban_panels` VALUES (91, 24, 'Peserta Terdaftar', '#4caf50', 3);
INSERT INTO `kanban_panels` VALUES (92, 25, 'Pembuatan', '#2196f3', 0);
INSERT INTO `kanban_panels` VALUES (93, 25, 'Pemeriksaan', '#3f51b5', 1);
INSERT INTO `kanban_panels` VALUES (101, 26, 'Pembuatan', '#9c27b0', 0);
INSERT INTO `kanban_panels` VALUES (102, 26, 'Pemeriksaan', '#e91e63', 1);
INSERT INTO `kanban_panels` VALUES (116, 30, 'Absensi', '#2196f3', 0);
INSERT INTO `kanban_panels` VALUES (118, 25, 'Penilaian', '#e91e63', 2);
INSERT INTO `kanban_panels` VALUES (120, 26, 'Pengesahan', '#009688', 2);
INSERT INTO `kanban_panels` VALUES (121, 25, 'Penerimaan', '#ffc107', 3);

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
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of kanban_settings
-- ----------------------------
INSERT INTO `kanban_settings` VALUES (24, 'Template Pendaftaran', 'Template module pendafaran', NULL, 'pendaftaran', NULL, 0);
INSERT INTO `kanban_settings` VALUES (25, 'Template SKP', 'Template module SKP Tahunan', NULL, 'skp', NULL, 0);
INSERT INTO `kanban_settings` VALUES (26, 'Template LKH', 'Template module LKH', NULL, 'lkh', NULL, 0);
INSERT INTO `kanban_settings` VALUES (30, 'Template Absensi', 'Template module absensi', NULL, 'absensi', NULL, 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 144 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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
INSERT INTO `kanban_statuses` VALUES (139, 118, 65, 791, '#000');
INSERT INTO `kanban_statuses` VALUES (141, 120, 64, 792, '#000');
INSERT INTO `kanban_statuses` VALUES (142, 121, 65, 794, '#000');
INSERT INTO `kanban_statuses` VALUES (143, 101, 64, 795, '#000');

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
) ENGINE = InnoDB AUTO_INCREMENT = 81 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_activities
-- ----------------------------
INSERT INTO `sys_activities` VALUES (1, 41, 'lkh', 5, 'add_task', 4, '2018-04-18 00:42:55', 'Pejabat Kapus (April 2018)', '{\"date\":\"2018-04-18\",\"desc\":\"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua\"}', '[\"1\",\"2\",\"3\",\"4\"]', '[\"2\",\"3\"]');
INSERT INTO `sys_activities` VALUES (2, 41, 'lkh', 5, 'add_task', 4, '2018-04-18 00:43:58', 'Pejabat Kapus (April 2018)', '{\"date\":\"2018-04-18\",\"desc\":\"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua\"}', '[\"1\",\"2\",\"3\",\"4\"]', '[\"2\",\"3\"]');
INSERT INTO `sys_activities` VALUES (3, 41, 'lkh', 5, 'add_user', 1, '2018-04-18 00:45:56', 'Pejabat Kapus (April 2018)', '[{\"su_id\":\"25\",\"su_fullname\":\"Roso Sasongko\"}]', '[\"1\",\"2\",\"3\",\"4\",\"25\"]', '[\"2\",\"3\",\"25\"]');
INSERT INTO `sys_activities` VALUES (4, 41, 'lkh', 5, 'remove_user', 4, '2018-04-18 00:46:24', 'Pejabat Kapus (April 2018)', '[{\"su_id\":\"25\",\"su_fullname\":\"Roso Sasongko\"}]', '[\"1\",\"2\",\"3\",\"4\"]', '[\"2\",\"3\"]');
INSERT INTO `sys_activities` VALUES (11, 41, 'lkh', 6, 'warning', 4, '2018-04-18 01:32:04', 'Administrator (April 2018)', '{\"comment\":\"<p>Pemberitahuan outstanding kegiatan harian tanggal 18 Apr 2018.<\\/p>\"}', '[\"1\"]', '[]');
INSERT INTO `sys_activities` VALUES (12, 41, 'lkh', 6, 'warning', 1, '2018-04-18 01:39:28', 'Administrator (April 2018)', '{\"comment\":\"<p>Pemberitahuan outstanding kegiatan harian tanggal 18 Apr 2018.<\\/p>\"}', '[\"1\"]', '[]');
INSERT INTO `sys_activities` VALUES (13, 41, 'lkh', 6, 'warning', 1, '2018-04-18 01:39:38', 'Administrator (April 2018)', '{\"comment\":\"<p>Pemberitahuan outstanding kegiatan harian tanggal 18 Apr 2018.<\\/p>\"}', '[\"1\"]', '[]');
INSERT INTO `sys_activities` VALUES (14, 41, 'lkh', 6, 'warning', 1, '2018-04-18 01:39:44', 'Administrator (April 2018)', '{\"comment\":\"<p>Pemberitahuan outstanding kegiatan harian tanggal 18 Apr 2018.<\\/p>\"}', '[\"1\"]', '[]');
INSERT INTO `sys_activities` VALUES (15, 41, 'lkh', 6, 'warning', 1, '2018-04-18 01:46:52', 'Administrator (April 2018)', '{\"comment\":\"<p>Pemberitahuan outstanding kegiatan harian tanggal 18 Apr 2018.<\\/p>\"}', '[\"1\"]', '[]');
INSERT INTO `sys_activities` VALUES (16, 41, 'lkh', 5, 'warning', 1, '2018-04-18 01:47:00', 'Pejabat Kapus (April 2018)', '{\"comment\":\"<p>Pemberitahuan outstanding kegiatan harian tanggal 18 Apr 2018.<\\/p>\"}', '[\"4\"]', '[]');
INSERT INTO `sys_activities` VALUES (27, NULL, NULL, NULL, 'alert', 4, '2018-04-18 02:13:59', NULL, '{\"message\":\"Outstanding kegiatan harian tanggal 18 Apr 2018\"}', '[\"1\"]', '[]');
INSERT INTO `sys_activities` VALUES (28, NULL, NULL, NULL, 'alert', 4, '2018-04-18 02:14:54', NULL, '{\"message\":\"Outstanding kegiatan harian tanggal 18 Apr 2018 - tolong disegerakan\"}', '[\"1\"]', '[]');
INSERT INTO `sys_activities` VALUES (30, NULL, NULL, NULL, 'alert', 1, '2018-04-18 02:16:32', NULL, '{\"message\":\"Outstanding kegiatan harian tanggal 18 Apr 2018\"}', '[\"16\"]', '[]');
INSERT INTO `sys_activities` VALUES (31, NULL, NULL, NULL, 'alert', 1, '2018-04-18 02:16:40', NULL, '{\"message\":\"Outstanding kegiatan harian tanggal 18 Apr 2018\"}', '[\"1\"]', '[]');
INSERT INTO `sys_activities` VALUES (32, NULL, NULL, NULL, 'alert', 4, '2018-04-18 02:18:58', NULL, '{\"message\":\"Outstanding kegiatan harian tanggal 18 Apr 2018\"}', '[\"1\"]', '[]');
INSERT INTO `sys_activities` VALUES (33, 41, 'lkh', 7, 'create', 1, '2018-04-18 04:22:46', 'Administrator (April 2018)', NULL, '[]', '[]');
INSERT INTO `sys_activities` VALUES (34, 41, 'lkh', 7, 'add_user', 1, '2018-04-18 04:22:46', 'Administrator (April 2018)', '[{\"su_id\":\"1\",\"su_fullname\":\"Administrator\"},{\"su_id\":\"2\",\"su_fullname\":\"Pejabat E4\"},{\"su_id\":\"4\",\"su_fullname\":\"Pejabat Kapus\"}]', '[\"1\",\"2\",\"4\"]', '[\"2\",\"4\"]');
INSERT INTO `sys_activities` VALUES (35, 41, 'lkh', 8, 'create', 1, '2018-04-18 04:23:10', 'Administrator (Mei 2018)', NULL, '[]', '[]');
INSERT INTO `sys_activities` VALUES (36, 41, 'lkh', 8, 'add_user', 1, '2018-04-18 04:23:10', 'Administrator (Mei 2018)', '[{\"su_id\":\"1\",\"su_fullname\":\"Administrator\"},{\"su_id\":\"2\",\"su_fullname\":\"Pejabat E4\"},{\"su_id\":\"4\",\"su_fullname\":\"Pejabat Kapus\"}]', '[\"1\",\"2\",\"4\"]', '[\"2\",\"4\"]');
INSERT INTO `sys_activities` VALUES (37, 41, 'lkh', 9, 'create', 1, '2018-04-18 04:27:08', 'Administrator (Juni 2018)', NULL, '[]', '[]');
INSERT INTO `sys_activities` VALUES (38, 41, 'lkh', 9, 'add_user', 1, '2018-04-18 04:27:08', 'Administrator (Juni 2018)', '[{\"su_id\":\"1\",\"su_fullname\":\"Administrator\"},{\"su_id\":\"2\",\"su_fullname\":\"Pejabat E4\"},{\"su_id\":\"4\",\"su_fullname\":\"Pejabat Kapus\"}]', '[\"1\",\"2\",\"4\"]', '[\"2\",\"4\"]');
INSERT INTO `sys_activities` VALUES (39, 41, 'lkh', 10, 'create', 1, '2018-04-18 04:27:27', 'Administrator (Juli 2018)', NULL, '[]', '[]');
INSERT INTO `sys_activities` VALUES (40, 41, 'lkh', 10, 'add_user', 1, '2018-04-18 04:27:27', 'Administrator (Juli 2018)', '[{\"su_id\":\"1\",\"su_fullname\":\"Administrator\"},{\"su_id\":\"3\",\"su_fullname\":\"Pejabat E3\"},{\"su_id\":\"4\",\"su_fullname\":\"Pejabat Kapus\"}]', '[\"1\",\"3\",\"4\"]', '[\"3\",\"4\"]');
INSERT INTO `sys_activities` VALUES (41, 41, 'lkh', 11, 'create', 1, '2018-04-18 04:28:10', 'Administrator (Agustus 2018)', NULL, '[]', '[]');
INSERT INTO `sys_activities` VALUES (42, 41, 'lkh', 11, 'add_user', 1, '2018-04-18 04:28:10', 'Administrator (Agustus 2018)', '[{\"su_id\":\"1\",\"su_fullname\":\"Administrator\"}]', '[\"1\"]', '[]');
INSERT INTO `sys_activities` VALUES (43, 41, 'lkh', 12, 'create', 1, '2018-04-18 04:28:37', 'Administrator (September 2018)', NULL, '[]', '[]');
INSERT INTO `sys_activities` VALUES (44, 41, 'lkh', 12, 'add_user', 1, '2018-04-18 04:28:37', 'Administrator (September 2018)', '[{\"su_id\":\"1\",\"su_fullname\":\"Administrator\"}]', '[\"1\"]', '[]');
INSERT INTO `sys_activities` VALUES (45, 41, 'lkh', 13, 'create', 1, '2018-04-18 04:28:51', 'Administrator (Oktober 2018)', NULL, '[]', '[]');
INSERT INTO `sys_activities` VALUES (46, 41, 'lkh', 13, 'add_user', 1, '2018-04-18 04:28:51', 'Administrator (Oktober 2018)', '[{\"su_id\":\"1\",\"su_fullname\":\"Administrator\"}]', '[\"1\"]', '[]');
INSERT INTO `sys_activities` VALUES (47, 41, 'lkh', 14, 'create', 1, '2018-04-18 04:36:00', 'Administrator (Februari 2018)', NULL, '[]', '[]');
INSERT INTO `sys_activities` VALUES (48, 41, 'lkh', 14, 'add_user', 1, '2018-04-18 04:36:00', 'Administrator (Februari 2018)', '[{\"su_id\":\"1\",\"su_fullname\":\"Administrator\"}]', '[\"1\"]', '[]');
INSERT INTO `sys_activities` VALUES (49, 41, 'lkh', 15, 'create', 1, '2018-04-18 04:36:17', 'Administrator (Maret 2018)', NULL, '[]', '[]');
INSERT INTO `sys_activities` VALUES (50, 41, 'lkh', 15, 'add_user', 1, '2018-04-18 04:36:17', 'Administrator (Maret 2018)', '[{\"su_id\":\"1\",\"su_fullname\":\"Administrator\"}]', '[\"1\"]', '[]');
INSERT INTO `sys_activities` VALUES (51, 41, 'lkh', 16, 'create', 1, '2018-04-18 04:36:43', 'Administrator (November 2018)', NULL, '[]', '[]');
INSERT INTO `sys_activities` VALUES (52, 41, 'lkh', 16, 'add_user', 1, '2018-04-18 04:36:43', 'Administrator (November 2018)', '[{\"su_id\":\"1\",\"su_fullname\":\"Administrator\"}]', '[\"1\"]', '[]');
INSERT INTO `sys_activities` VALUES (53, 41, 'lkh', 17, 'create', 1, '2018-04-18 04:36:56', 'Administrator (Desember 2018)', NULL, '[]', '[]');
INSERT INTO `sys_activities` VALUES (54, 41, 'lkh', 17, 'add_user', 1, '2018-04-18 04:36:56', 'Administrator (Desember 2018)', '[{\"su_id\":\"1\",\"su_fullname\":\"Administrator\"}]', '[\"1\"]', '[]');
INSERT INTO `sys_activities` VALUES (55, 41, 'lkh', 4, 'add_task', 1, '2018-04-18 22:35:27', 'Administrator (Januari 2018)', '{\"date\":\"2018-01-01\",\"desc\":\"Koreksi dan Diskusi Pembuatan SK\"}', '[\"1\",\"2\",\"4\"]', '[\"2\",\"4\"]');
INSERT INTO `sys_activities` VALUES (56, 41, 'lkh', 4, 'add_task', 1, '2018-04-18 22:35:48', 'Administrator (Januari 2018)', '{\"date\":\"2018-01-02\",\"desc\":\"Melakukan Survey Penyusunan Indek Mutu Diklat Di BDK Bandung\"}', '[\"1\",\"2\",\"4\"]', '[\"2\",\"4\"]');
INSERT INTO `sys_activities` VALUES (57, 41, 'lkh', 4, 'add_task', 1, '2018-04-18 22:35:59', 'Administrator (Januari 2018)', '{\"date\":\"2018-01-03\",\"desc\":\"Melakukan Survey Penyusunan Indek Mutu Diklat Di BDK Bandung\"}', '[\"1\",\"2\",\"4\"]', '[\"2\",\"4\"]');
INSERT INTO `sys_activities` VALUES (58, 41, 'lkh', 4, 'add_task', 1, '2018-04-18 22:36:15', 'Administrator (Januari 2018)', '{\"date\":\"2018-01-04\",\"desc\":\"Melakukan Survey Penyusunan Indek Mutu Diklat Di BDK Bandung\"}', '[\"1\",\"2\",\"4\"]', '[\"2\",\"4\"]');
INSERT INTO `sys_activities` VALUES (59, 41, 'lkh', 4, 'add_task', 1, '2018-04-18 22:37:05', 'Administrator (Januari 2018)', '{\"date\":\"2018-01-06\",\"desc\":\"Mengikuti Fullday Penyusunan\\/Pengembangan Kurikulum Silabus Diklat Teknis Administrasi pada Lembaga Pendidikan (Tahap Pembahasan)\"}', '[\"1\",\"2\",\"4\"]', '[\"2\",\"4\"]');
INSERT INTO `sys_activities` VALUES (60, 41, 'lkh', 18, 'create', 16, '2018-04-19 02:46:45', 'Operator (April 2018)', NULL, '[]', '[]');
INSERT INTO `sys_activities` VALUES (61, 41, 'lkh', 18, 'add_user', 16, '2018-04-19 02:46:45', 'Operator (April 2018)', '[{\"su_id\":\"16\",\"su_fullname\":\"Operator\"},{\"su_id\":\"1\",\"su_fullname\":\"Administrator\"},{\"su_id\":\"2\",\"su_fullname\":\"Pejabat E4\"},{\"su_id\":\"4\",\"su_fullname\":\"Pejabat Kapus\"}]', '[\"1\",\"2\",\"4\",\"16\"]', '[\"2\",\"4\"]');
INSERT INTO `sys_activities` VALUES (62, 41, 'lkh', 18, 'add_task', 16, '2018-04-19 02:50:38', 'Operator (April 2018)', '{\"date\":\"2018-04-01\",\"desc\":\"Melakukan Survey Penyusunan Indek Mutu Diklat Di BDK Bandung\"}', '[\"1\",\"2\",\"4\",\"16\"]', '[\"2\",\"4\"]');
INSERT INTO `sys_activities` VALUES (63, 41, 'lkh', 18, 'add_task', 16, '2018-04-19 02:53:42', 'Operator (April 2018)', '{\"date\":\"2018-04-19\",\"desc\":\"Mengikuti Fullday Penyusunan\\/Pengembangan Kurikulum Silabus Diklat Teknis Administrasi pada Lembaga Pendidikan (Tahap Pembahasan)\"}', '[\"1\",\"2\",\"4\",\"16\"]', '[\"2\",\"4\"]');
INSERT INTO `sys_activities` VALUES (64, 41, 'lkh', 18, 'add_task', 16, '2018-04-19 02:54:11', 'Operator (April 2018)', '{\"date\":\"2018-04-19\",\"desc\":\"Mengikuti Fullday Penyusunan\\/Pengembangan Kurikulum Silabus Diklat Teknis Administrasi pada Lembaga Pendidikan (Tahap Pembahasan)\"}', '[\"1\",\"2\",\"4\",\"16\"]', '[\"2\",\"4\"]');
INSERT INTO `sys_activities` VALUES (65, 41, 'lkh', 7, 'warning', 1, '2018-04-19 20:41:00', 'Administrator (April 2018)', '{\"comment\":\"<p>Outstanding kegiatan harian tanggal 19 Apr 2018<\\/p>\"}', '[\"1\"]', '[]');
INSERT INTO `sys_activities` VALUES (66, 41, 'lkh', 7, 'warning', 1, '2018-04-19 20:41:25', 'Administrator (April 2018)', '{\"comment\":\"<p>Outstanding kegiatan harian tanggal 19 Apr 2018<\\/p>\"}', '[\"1\"]', '[]');
INSERT INTO `sys_activities` VALUES (67, NULL, NULL, NULL, 'alert', 1, '2018-04-19 20:42:54', NULL, '{\"message\":\"Outstanding kegiatan harian tanggal 19 Apr 2018\"}', '[\"25\"]', '[\"25\"]');
INSERT INTO `sys_activities` VALUES (68, NULL, NULL, NULL, 'alert', 1, '2018-04-19 20:44:40', NULL, '{\"message\":\"Outstanding kegiatan harian tanggal 01 Apr 2018\"}', '[\"25\"]', '[\"25\"]');
INSERT INTO `sys_activities` VALUES (69, 41, 'lkh', 7, 'add_task', 1, '2018-04-21 00:15:49', 'Administrator (April 2018)', '{\"date\":\"2018-04-21\",\"desc\":\"Libur\"}', '[\"1\",\"2\",\"4\"]', '[\"2\",\"4\"]');
INSERT INTO `sys_activities` VALUES (70, 41, 'lkh', 7, 'update_status', 1, '2018-04-21 00:18:19', 'Administrator (April 2018)', '[\"Tahap Pemeriksaan\"]', '[\"1\",\"2\",\"4\"]', '[\"2\",\"4\"]');
INSERT INTO `sys_activities` VALUES (71, 41, 'lkh', 7, 'add_task', 1, '2018-04-21 00:23:03', 'Administrator (April 2018)', '{\"date\":\"2018-04-20\",\"desc\":\"Membaca\"}', '[\"1\",\"2\",\"4\"]', '[\"2\",\"4\"]');
INSERT INTO `sys_activities` VALUES (72, 41, 'lkh', 7, 'add_task', 1, '2018-04-21 00:49:14', 'Administrator (April 2018)', '{\"date\":\"2018-04-01\",\"desc\":\"Libur\"}', '[\"1\",\"2\",\"4\"]', '[\"2\",\"4\"]');
INSERT INTO `sys_activities` VALUES (73, 41, 'lkh', 7, 'add_task', 1, '2018-04-21 17:48:10', 'Administrator (April 2018)', '{\"date\":\"2018-04-22\",\"desc\":\"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua\"}', '[\"1\",\"2\",\"4\"]', '[\"2\",\"4\"]');
INSERT INTO `sys_activities` VALUES (74, 41, 'lkh', 7, 'add_task', 1, '2018-04-21 18:04:08', 'Administrator (April 2018)', '{\"date\":\"2018-04-23\",\"desc\":\"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua\"}', '[\"1\",\"2\",\"4\"]', '[\"2\",\"4\"]');
INSERT INTO `sys_activities` VALUES (75, 41, 'lkh', 7, 'add_task', 1, '2018-04-21 18:11:05', 'Administrator (April 2018)', '{\"date\":\"2018-04-22\",\"desc\":\"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua\"}', '[\"1\",\"2\",\"4\"]', '[\"2\",\"4\"]');
INSERT INTO `sys_activities` VALUES (76, 41, 'lkh', 7, 'add_task', 1, '2018-04-21 18:12:43', 'Administrator (April 2018)', '{\"date\":\"2018-04-22\",\"desc\":\"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua\"}', '[\"1\",\"2\",\"4\"]', '[\"2\",\"4\"]');
INSERT INTO `sys_activities` VALUES (77, 41, 'lkh', 7, 'add_task', 1, '2018-04-21 18:14:32', 'Administrator (April 2018)', '{\"date\":\"2018-04-22\",\"desc\":\"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua\"}', '[\"1\",\"2\",\"4\"]', '[\"2\",\"4\"]');
INSERT INTO `sys_activities` VALUES (78, 41, 'lkh', 7, 'add_task', 1, '2018-04-21 18:17:23', 'Administrator (April 2018)', '{\"date\":\"2018-04-22\",\"desc\":\"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua\"}', '[\"1\",\"2\",\"4\"]', '[\"2\",\"4\"]');
INSERT INTO `sys_activities` VALUES (79, 41, 'lkh', 4, 'update_status', 1, '2018-04-21 18:21:30', 'Administrator (Januari 2018)', '[\"Tahap Pemeriksaan\"]', '[\"1\",\"2\",\"4\"]', '[\"2\",\"4\"]');
INSERT INTO `sys_activities` VALUES (80, 41, 'lkh', 8, 'update_status', 1, '2018-04-21 18:23:31', 'Administrator (Mei 2018)', '[\"Tahap Pemeriksaan\"]', '[\"1\",\"2\",\"4\"]', '[\"2\",\"4\"]');

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
-- Records of sys_captcha
-- ----------------------------
INSERT INTO `sys_captcha` VALUES ('127.0.0.1', '8fca74ff-a152-4612-a230-f4afa672ab8b', 'unp', 'unp', 1524049354, NULL);

-- ----------------------------
-- Table structure for sys_company
-- ----------------------------
DROP TABLE IF EXISTS `sys_company`;
CREATE TABLE `sys_company`  (
  `scp_id` int(11) NOT NULL AUTO_INCREMENT,
  `scp_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `scp_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
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
INSERT INTO `sys_company` VALUES (1, 'Pusdiklat Tenaga Administrasi', 'Jl. Kemerdekaan No. 45, Ciputat, Tangerang Selatan', '(021) 77126162', '(021) 77182717', 'pusdikadm@kemenag.go.id', 'http://pta.kemenag.go.id', 1, NULL);

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
-- Table structure for sys_departments
-- ----------------------------
DROP TABLE IF EXISTS `sys_departments`;
CREATE TABLE `sys_departments`  (
  `sdp_id` int(11) NOT NULL AUTO_INCREMENT,
  `sdp_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sdp_evaluator` int(11) NULL DEFAULT NULL,
  `sdp_examiner` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`sdp_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_departments
-- ----------------------------
INSERT INTO `sys_departments` VALUES (1, 'Badan Litbang dan Diklat Kementerian Agama', 2, 3);

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
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_inbox
-- ----------------------------
INSERT INTO `sys_inbox` VALUES (2, 'TDZjazJDWTFNeEpXM0tLSGIrZjRNdz09', 'xxxxxxxxxxxxx', 1, 2, '2018-03-10 22:37:28', '<p>xxxxxxxxxxxxxxxxxxxxxxxxx</p>', 0, 0, NULL);
INSERT INTO `sys_inbox` VALUES (7, 'QnFRb25qUDZIUUx1MEpoMmpXRERTUT09', 'xxxxxxxxxxx', 1, 2, '2018-03-10 23:22:34', '<p>xxxxxxxxxxxxx</p>', 0, 0, NULL);
INSERT INTO `sys_inbox` VALUES (8, 'NFAvdU50RkdYQ2Z1aXliYVZKR3FlQT09', 'asasa', 1, 2, '2018-03-10 23:22:58', '<p><br></p>', 0, 0, NULL);
INSERT INTO `sys_inbox` VALUES (10, 'S1dNVGE2QUs1MytEVk9HY3hUTzRwdz09', '123', 1, 25, '2018-03-10 23:40:28', '<p>123</p>', 0, 0, NULL);
INSERT INTO `sys_inbox` VALUES (11, 'QzFHbWlXZ3dDL2lVcnpmUUJUM2xlUT09', 'xxx', 1, 2, '2018-03-10 23:45:37', '<p>xxx</p>', 0, 0, '2018-03-10 23:45:37');
INSERT INTO `sys_inbox` VALUES (23, 'cnhzdVRXTE9DUzhCY291TFBzTVhyZz09', NULL, 1, 2, '2018-03-11 01:44:00', '<p><br></p>', 0, 0, '2018-03-11 01:44:00');
INSERT INTO `sys_inbox` VALUES (24, 'VkJiQVAzN04vb0V1TmdtZFkxVU5BZz09', NULL, 1, 16, '2018-03-11 01:44:00', '<p><br></p>', 0, 0, '2018-03-11 01:44:00');
INSERT INTO `sys_inbox` VALUES (30, 'bzZLMnhiSW9nbDhhZ200bXhDVnJadz09', 'Are there any built in auto-complete input components for Polymer 1.0', 1, 2, '2018-03-11 02:03:46', '<p style=\"color: rgb(36, 39, 41);\">Is there one built-in or planned in the paper or iron Polymer controls? Or should I be looking at autocomplete solutions from other frameworks? So far, I\'ve been able to keep my app light-weight, and I\'d prefer to avoid other frameworks if I can help it</p>', 0, 0, '2018-03-11 02:03:46');

-- ----------------------------
-- Table structure for sys_jobs
-- ----------------------------
DROP TABLE IF EXISTS `sys_jobs`;
CREATE TABLE `sys_jobs`  (
  `sj_id` int(11) NOT NULL AUTO_INCREMENT,
  `sj_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sj_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_jobs
-- ----------------------------
INSERT INTO `sys_jobs` VALUES (1, 'Jabatan Fungsional Umum');
INSERT INTO `sys_jobs` VALUES (2, 'Kasubid Diklat Teknis Administrasi dan Fungsional');
INSERT INTO `sys_jobs` VALUES (3, 'Kepala Bidang  Penyelenggaraan Diklat ');
INSERT INTO `sys_jobs` VALUES (4, 'Kepala Pusdiklat Administrasi');

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
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_projects
-- ----------------------------
INSERT INTO `sys_projects` VALUES (36, 'private', 'private', 'Private', NULL, NULL, NULL, 7, '2018-01-20 02:34:17', 19);
INSERT INTO `sys_projects` VALUES (39, 'private', 'pendaftaran', 'Pendaftaran', 'Module pendaftaran peserta', NULL, NULL, 1, '2018-01-24 07:02:26', 24);
INSERT INTO `sys_projects` VALUES (40, 'public', 'skp', 'SKP', 'Module manajemen dokumen SKP', NULL, NULL, 1, '2018-01-24 07:28:32', 25);
INSERT INTO `sys_projects` VALUES (41, 'public', 'lkh', 'LKH', 'Module agenda harian', NULL, NULL, 1, '2018-01-24 07:33:31', 26);

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
  `spu_sp_id` bigint(20) NULL DEFAULT NULL,
  `spu_su_id` bigint(20) NULL DEFAULT NULL,
  `spu_id` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`spu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 95 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_projects_users
-- ----------------------------
INSERT INTO `sys_projects_users` VALUES (20, 7, 12);
INSERT INTO `sys_projects_users` VALUES (21, 7, 13);
INSERT INTO `sys_projects_users` VALUES (36, 7, 73);
INSERT INTO `sys_projects_users` VALUES (39, 1, 81);
INSERT INTO `sys_projects_users` VALUES (40, 1, 82);
INSERT INTO `sys_projects_users` VALUES (41, 1, 83);
INSERT INTO `sys_projects_users` VALUES (39, 16, 94);

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
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_roles
-- ----------------------------
INSERT INTO `sys_roles` VALUES (4, 'Administator', 'administator', 'Role untuk pengguna administrator', 1, '2017-05-24 18:48:45', 'system');
INSERT INTO `sys_roles` VALUES (7, 'Eselon IV', 'eselon-iv', 'Role untuk pengguna grade Eselon IV', 0, '2017-09-18 09:00:50', 'system');
INSERT INTO `sys_roles` VALUES (16, 'Eselon III', 'eselon-iii', 'Role untuk pengguna grade Eselon III', 0, '2018-01-11 10:27:53', 'system');
INSERT INTO `sys_roles` VALUES (17, 'Kapus', 'kapus', 'Role untuk pengguna grade Kapus', 0, '2018-01-23 22:17:33', 'system');
INSERT INTO `sys_roles` VALUES (18, 'Staff', 'staff', 'Role untuk pengguna grade staff', 0, '2018-01-23 22:17:52', 'system');
INSERT INTO `sys_roles` VALUES (19, 'Peserta', 'peserta', 'Role untuk pengguna biasa atau peserta', 0, '2018-01-24 19:34:47', 'system');
INSERT INTO `sys_roles` VALUES (20, 'Operator', 'operator', 'Role untuk pengguna operator atau input data', 0, '2018-01-28 02:39:02', 'system');

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
) ENGINE = InnoDB AUTO_INCREMENT = 82 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_roles_menus
-- ----------------------------
INSERT INTO `sys_roles_menus` VALUES (1, 4, 1, 5, 1);
INSERT INTO `sys_roles_menus` VALUES (8, 4, 7, 17, 1);
INSERT INTO `sys_roles_menus` VALUES (9, 4, 19, 18, 1);
INSERT INTO `sys_roles_menus` VALUES (10, 4, 20, 19, 1);
INSERT INTO `sys_roles_menus` VALUES (11, 16, 1, NULL, 1);
INSERT INTO `sys_roles_menus` VALUES (12, 16, 3, NULL, 1);
INSERT INTO `sys_roles_menus` VALUES (13, 16, 7, NULL, 0);
INSERT INTO `sys_roles_menus` VALUES (14, 16, 19, NULL, 1);
INSERT INTO `sys_roles_menus` VALUES (15, 16, 20, NULL, 1);
INSERT INTO `sys_roles_menus` VALUES (17, 7, 19, NULL, 1);
INSERT INTO `sys_roles_menus` VALUES (18, 7, 1, NULL, 1);
INSERT INTO `sys_roles_menus` VALUES (19, 17, 1, 5, 1);
INSERT INTO `sys_roles_menus` VALUES (20, 17, 3, 27, 1);
INSERT INTO `sys_roles_menus` VALUES (21, 17, 19, 18, 1);
INSERT INTO `sys_roles_menus` VALUES (22, 18, 1, NULL, 1);
INSERT INTO `sys_roles_menus` VALUES (23, 18, 3, NULL, 1);
INSERT INTO `sys_roles_menus` VALUES (24, 18, 7, NULL, 0);
INSERT INTO `sys_roles_menus` VALUES (25, 18, 19, NULL, 1);
INSERT INTO `sys_roles_menus` VALUES (26, 18, 20, NULL, 1);
INSERT INTO `sys_roles_menus` VALUES (27, 7, 3, NULL, 1);
INSERT INTO `sys_roles_menus` VALUES (28, 7, 20, NULL, 1);
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
INSERT INTO `sys_roles_menus` VALUES (47, 4, NULL, 3, 0);
INSERT INTO `sys_roles_menus` VALUES (49, 4, NULL, 2, 0);
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
) ENGINE = InnoDB AUTO_INCREMENT = 63 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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
INSERT INTO `sys_roles_permissions` VALUES (35, 17, 31, 1);
INSERT INTO `sys_roles_permissions` VALUES (36, 17, 32, 1);
INSERT INTO `sys_roles_permissions` VALUES (37, 18, 31, 1);
INSERT INTO `sys_roles_permissions` VALUES (38, 18, 32, 1);
INSERT INTO `sys_roles_permissions` VALUES (39, 19, 31, 1);
INSERT INTO `sys_roles_permissions` VALUES (40, 19, 32, 1);
INSERT INTO `sys_roles_permissions` VALUES (41, 20, 31, 1);
INSERT INTO `sys_roles_permissions` VALUES (42, 20, 32, 1);
INSERT INTO `sys_roles_permissions` VALUES (43, 4, 33, 1);
INSERT INTO `sys_roles_permissions` VALUES (44, 17, 33, 0);
INSERT INTO `sys_roles_permissions` VALUES (45, 4, 34, 1);
INSERT INTO `sys_roles_permissions` VALUES (46, 4, 35, 1);
INSERT INTO `sys_roles_permissions` VALUES (47, 4, 36, 1);
INSERT INTO `sys_roles_permissions` VALUES (48, 4, 37, 1);
INSERT INTO `sys_roles_permissions` VALUES (49, 17, 34, 1);
INSERT INTO `sys_roles_permissions` VALUES (50, 17, 35, 1);
INSERT INTO `sys_roles_permissions` VALUES (51, 17, 36, 1);
INSERT INTO `sys_roles_permissions` VALUES (52, 17, 37, 1);
INSERT INTO `sys_roles_permissions` VALUES (53, 20, 34, 1);
INSERT INTO `sys_roles_permissions` VALUES (54, 20, 35, 1);
INSERT INTO `sys_roles_permissions` VALUES (55, 20, 36, 1);
INSERT INTO `sys_roles_permissions` VALUES (56, 20, 37, 1);
INSERT INTO `sys_roles_permissions` VALUES (57, 4, 38, 1);
INSERT INTO `sys_roles_permissions` VALUES (58, 17, 38, 1);
INSERT INTO `sys_roles_permissions` VALUES (59, 20, 38, 1);
INSERT INTO `sys_roles_permissions` VALUES (60, 4, 39, 1);
INSERT INTO `sys_roles_permissions` VALUES (61, 17, 39, 1);
INSERT INTO `sys_roles_permissions` VALUES (62, 20, 39, 1);

-- ----------------------------
-- Table structure for sys_units
-- ----------------------------
DROP TABLE IF EXISTS `sys_units`;
CREATE TABLE `sys_units`  (
  `sun_id` int(11) NOT NULL AUTO_INCREMENT,
  `sun_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sun_id`) USING BTREE,
  INDEX `sun_idx_0`(`sun_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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
  `su_avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `su_access_token` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `su_invite_token` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `su_recover_token` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `su_device_token` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `su_feed_read` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `su_sex` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `su_pob` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `su_dob` date NULL DEFAULT NULL,
  `su_scp_id` int(11) NULL DEFAULT NULL,
  `su_sdp_id` int(11) NULL DEFAULT NULL,
  `su_grade` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `su_sj_id` int(11) NULL DEFAULT NULL,
  `su_active` int(11) NULL DEFAULT 0,
  `su_task_due` date NULL DEFAULT NULL,
  `su_task_project` bigint(20) NULL DEFAULT NULL,
  `su_task_flag` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `su_incognito` int(1) NULL DEFAULT 0,
  `su_created_dt` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP,
  `su_created_by` int(11) NULL DEFAULT NULL,
  `su_updated_dt` datetime(0) NULL DEFAULT NULL,
  `su_updated_by` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`su_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_users
-- ----------------------------
INSERT INTO `sys_users` VALUES (1, '198503302003121001', 4, 'admin@pusdikadm.xyz', '$2y$08$T2h2cWZaU0lIWUpoMFBKSuwWvsjYotQZm5i7AJntaEAOZ2cymi/iu', 'Administrator', 'Miniclip-8-Ball-Pool-Avatar-15-180x180.png', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MjQzMDc1NTcsImp0aSI6ImZLaFwvekIrWGZZZ1VtU1RcL1wvMU00eDc5VDVudmNYZkFaYjdrM3l6ZUZvbkk9IiwiaXNzIjoiUFVTRElLQURNIiwibmJmIjoxNTI0MzA3NTU4LCJleHAiOjE1MjQzOTE1NTgsImRhdGEiOnsic3VfZW1haWwiOiJhZG1pbkBwdXNkaWthZG0ueHl6Iiwic3Vfc3JfaWQiOiI0In19.Ip7lklD9_yHxJvvtUT5toQgMwVmuOHDg1VwlX2rWvXS1B4uiOSltk6uMZftOnrcHy891qFv7NFSeDRCTYBskkA', NULL, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MTU2MjQ1NjgsImp0aSI6ImlJbE1VOXdaUGpmd2ZUbk9hMkdUK0oyQlVNTDZCa09oSkx1VFpJa2pCZVU9IiwiaXNzIjoiS3JlYXNpbmRvIENpcHRhIFRla25vbG9naSIsIm5iZiI6MTUxNTYyNDU2OSwiZXhwIjoxNTE1NzA4NTY5LCJkYXRhIjp7InN1X2VtYWlsIjoicm9zb0BrY3QuY28uaWQifX0.o1iI7ZWpATPgALV2P6Frdv09XcMnuIAWd6lImKyZqQN6Y5xp-_JhHC1nxDppVMEUs9qIBOFc8KNHHpBiYM-KZw', NULL, '[\"1:1\"]', 'Laki-laki', 'Banyumas', '1985-07-03', 1, 1, 'Penata, III/C', 1, 1, NULL, NULL, NULL, 0, '2017-04-27 20:52:36', NULL, NULL, NULL);
INSERT INTO `sys_users` VALUES (2, '198503302003121002', 7, 'eselon4@pusdikadm.xyz', '$2y$08$UWRzU3lrK0NFekprSWdpVelnCWtgEvCMORxnS3kSjUEGzBxxBx1lK', 'Pejabat E4', 'default-avatar-male_12.png', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MTY4NDQwMDcsImp0aSI6InNcL0ZObWJWS3dnXC9kVU4rcnNrNlhFMnRzcVl2S3I1OWkrVWhQckl3V1ErOD0iLCJpc3MiOiJLcmVhc2luZG8gQ2lwdGEgVGVrbm9sb2dpIiwibmJmIjoxNTE2ODQ0MDA4LCJleHAiOjE1MTY5MjgwMDgsImRhdGEiOnsic3VfZW1haWwiOiJ2aWRpQGtjdC5jby5pZCIsInN1X3NyX2lkIjoiNyJ9fQ.izKMm0aLfoJoRkKNrjNLjTxix73U_k8wUCBlgvARVCDHKYvde6vSb07fSMV60GP-Y7_FRfLWhAp0ukHgv_kVIg', NULL, NULL, NULL, NULL, 'Female', 'Cilacap', '2018-03-12', 1, 1, 'Penata/III.D', 2, 1, NULL, NULL, NULL, 0, '2017-05-04 05:55:15', NULL, NULL, NULL);
INSERT INTO `sys_users` VALUES (3, '198503302003121003', 16, 'eselon3@pusdikadm.xyz', '$2y$08$NkpiM3VlR3JlNFZqU2hsceEVsA410evwpUesAl.GKYGKxfehDXEWW', 'Pejabat E3', 'eselon3_pusdikadm_xyz.png', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MTM4MDIxMzcsImp0aSI6Ilp6dXR6SktJaUR3NGNYM0JcL0dcL1dXS280XC9Qb001bmhNd3dPUlNQK1lCcFk9IiwiaXNzIjoiS3JlYXNpbmRvIENpcHRhIFRla25vbG9naSIsIm5iZiI6MTUxMzgwMjEzOCwiZXhwIjoxNTEzODg2MTM4LCJkYXRhIjp7InN1X2VtYWlsIjoiY2FoeWFAa2N0LmNvLmlkIiwic3Vfc3JfaWQiOjR9fQ._ARstWVDFeJw2EGcYYa-ALxPMvC_Kt0AoYBY9l2rI09W1nYaVsVW6z014JvO_iL5iGpv62OjbDWb_ZoT0ps4hw', NULL, NULL, NULL, NULL, 'Male', NULL, NULL, 1, 1, 'Penata/III.D', 3, 1, NULL, NULL, NULL, 0, '2017-05-04 06:24:39', NULL, NULL, NULL);
INSERT INTO `sys_users` VALUES (4, '198503302003121004', 17, 'kapus@pusdikadm.xyz', '$2y$08$R25qRXFZQUlZYXBKR0JpeOqrd5lLB0WKsdZBzvv.1dfe9qmXm9OdK', 'Pejabat Kapus', 'kapus_pusdikadm_xyz.png', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MjQwODAwMDQsImp0aSI6Ims5aUpWSklCK0dHS0NmZTFVd2RLOERNdXhYemFDb1Jydlpjd0sxajR3RXM9IiwiaXNzIjoiUFVTRElLQURNIiwibmJmIjoxNTI0MDgwMDA1LCJleHAiOjE1MjQxNjQwMDUsImRhdGEiOnsic3VfZW1haWwiOiJrYXB1c0BwdXNkaWthZG0ueHl6Iiwic3Vfc3JfaWQiOiIxNyJ9fQ.AfCVGWfR6j97mlM2gwazzBg1eA72GB2gW6m0ZYymPg0zyGPWMCpMTnxlnUBudh-8d7NNipQnhJk9BGaYDuSU-Q', NULL, NULL, NULL, NULL, 'Female', 'Jakarta', '2018-03-19', 1, 1, 'Pembina/IVA', 4, 1, NULL, NULL, NULL, 0, '2017-05-04 07:20:15', NULL, NULL, NULL);
INSERT INTO `sys_users` VALUES (16, '198503302003121005', 20, 'operator@pusdikadm.xyz', '$2y$08$Y0hZVHJCR2xjWlpHZHlnMuyL5k7KZHUSyvXZV9mzcGjpReuqbkW1S', 'Operator', 'operator_pusdikadm_xyz.png', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MjQwODA3NzksImp0aSI6Ilorc0lKVFRscWg0NDdQVVg1NzkrYnhmZnpXeTVoZHVmSjVPQzlFTTdsZEE9IiwiaXNzIjoiUFVTRElLQURNIiwibmJmIjoxNTI0MDgwNzgwLCJleHAiOjE1MjQxNjQ3ODAsImRhdGEiOnsic3VfZW1haWwiOiJvcGVyYXRvckBwdXNkaWthZG0ueHl6Iiwic3Vfc3JfaWQiOiIyMCJ9fQ.8qwpnnnlPq3B91_GLYoCXVpX7SEPjvXeVKyTXxoUuWrq9MXWanDQl8uPTIfkfxIAAobg_nvH91dgzdwHz2gHHg', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MTQ0OTY1MDEsImp0aSI6IktTeVpnckMrRnpxXC9veE1CblpVNE9LbU02VlJZMEJQblpHMGZOeUVqVDY4PSIsImlzcyI6IktyZWFzaW5kbyBDaXB0YSBUZWtub2xvZ2kiLCJuYmYiOjE1MTQ0OTY1MDIsImV4cCI6MTUxNDU4MDUwMiwiZGF0YSI6eyJzdV9lbWFpbCI6Im51cmZhcmlkODkyNEBnbWFpbC5jb20ifX0.nMDmk6apzl5ukFF2gdXQbnXfa8i3rB3r5YmmfI3A4V28RwRypbrYIczaI8eO1ZqWQsZOrnhPyvqYBkH7ZxP99w', NULL, NULL, '[]', NULL, NULL, NULL, 1, 1, 'Staff, IVA', NULL, 1, NULL, NULL, NULL, 0, '2017-12-29 04:28:21', NULL, NULL, NULL);
INSERT INTO `sys_users` VALUES (25, '198503302003121006', 4, 'roso.sasongko@gmail.com', NULL, 'Roso Sasongko', 'defaults/avatar-0.jpg', NULL, NULL, NULL, NULL, NULL, 'Laki-laki', 'Banyumas', '2018-03-05', 1, 1, 'Penata/III.C', 1, 1, '2018-03-31', 39, NULL, 0, '2018-03-05 02:04:00', 1, '2018-03-05 18:35:56', 1);

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
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_users_tokens
-- ----------------------------
INSERT INTO `sys_users_tokens` VALUES (5, 1, 'gcm', 'chrome', 'fnCgvheJa7k:APA91bGfmeJUeFzQrWlsyoi7u0-KM6v9OHMcDFukYiqUF86sGjWdayfEYUo5Fz211rgS308Z0iMMHrsChIqQRzxKehhfcxd8jD3wA9Jm8mZXF38U0S7UP2XdSvEToXX08D0_8Bqb1j8j', '2018-04-16 14:38:18');

-- ----------------------------
-- Table structure for trx_behaviors
-- ----------------------------
DROP TABLE IF EXISTS `trx_behaviors`;
CREATE TABLE `trx_behaviors`  (
  `tbh_id` int(11) NOT NULL AUTO_INCREMENT,
  `tbh_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tbh_mandatory` int(1) NULL DEFAULT 1,
  PRIMARY KEY (`tbh_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_behaviors
-- ----------------------------
INSERT INTO `trx_behaviors` VALUES (1, 'Orientasi Pelayanan', 1);
INSERT INTO `trx_behaviors` VALUES (2, 'Integritas', 1);
INSERT INTO `trx_behaviors` VALUES (3, 'Komitmen', 1);
INSERT INTO `trx_behaviors` VALUES (4, 'Disiplin', 1);
INSERT INTO `trx_behaviors` VALUES (5, 'Kerjasama', 1);
INSERT INTO `trx_behaviors` VALUES (6, 'Kepemimpinan', 0);

-- ----------------------------
-- Table structure for trx_criteria
-- ----------------------------
DROP TABLE IF EXISTS `trx_criteria`;
CREATE TABLE `trx_criteria`  (
  `tcr_id` int(11) NOT NULL AUTO_INCREMENT,
  `tcr_max` double(15, 2) NULL DEFAULT NULL,
  `tcr_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tcr_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_criteria
-- ----------------------------
INSERT INTO `trx_criteria` VALUES (1, 50.00, 'Buruk');
INSERT INTO `trx_criteria` VALUES (2, 60.00, 'Kurang');
INSERT INTO `trx_criteria` VALUES (3, 75.00, 'Cukup');
INSERT INTO `trx_criteria` VALUES (4, 90.99, 'Baik');
INSERT INTO `trx_criteria` VALUES (5, 100.00, 'Sangat Baik');

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
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_items
-- ----------------------------
INSERT INTO `trx_items` VALUES (1, 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua', 1, 'lkh');
INSERT INTO `trx_items` VALUES (2, 'Menyusun undang undang', 1, 'lkh');
INSERT INTO `trx_items` VALUES (3, 'Menyusun laporan SKP 2018', 1, 'lkh');
INSERT INTO `trx_items` VALUES (4, 'A', 1, 'lkh');
INSERT INTO `trx_items` VALUES (5, 'B', 1, 'lkh');
INSERT INTO `trx_items` VALUES (6, 'C', 1, 'lkh');
INSERT INTO `trx_items` VALUES (7, 'FOO', 1, 'lkh');
INSERT INTO `trx_items` VALUES (8, 'BAR', 1, 'lkh');
INSERT INTO `trx_items` VALUES (9, 'BAZ', 1, 'lkh');
INSERT INTO `trx_items` VALUES (10, 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua', 4, 'lkh');
INSERT INTO `trx_items` VALUES (11, 'Koreksi dan Diskusi Pembuatan SK', 1, 'lkh');
INSERT INTO `trx_items` VALUES (12, 'Finalisasi Bahan Sosialisasi Produk Kediklatan', 1, 'lkh');
INSERT INTO `trx_items` VALUES (13, 'Melakukan Survey Penyusunan Indek Mutu Diklat Di BDK Bandung', 1, 'lkh');
INSERT INTO `trx_items` VALUES (14, 'Mengikuti Fullday Penyusunan/Pengembangan Kurikulum Silabus Diklat Teknis Administrasi pada Lembaga Pendidikan (Tahap Pembahasan)', 1, 'lkh');
INSERT INTO `trx_items` VALUES (15, 'Melakukan Survey Penyusunan Indek Mutu Diklat Di BDK Bandung', 16, 'lkh');
INSERT INTO `trx_items` VALUES (16, 'Mengikuti Fullday Penyusunan/Pengembangan Kurikulum Silabus Diklat Teknis Administrasi pada Lembaga Pendidikan (Tahap Pembahasan)', 16, 'lkh');
INSERT INTO `trx_items` VALUES (17, 'Libur', 1, 'lkh');
INSERT INTO `trx_items` VALUES (18, 'Membaca', 1, 'lkh');

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
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_lkh
-- ----------------------------
INSERT INTO `trx_lkh` VALUES (2, 'Maret 2018', 1, '2018-03-01', '2018-03-31', 3, 4, 41, '2018-04-16', '2018-04-16 14:09:40', 1, '2018-04-16 17:17:28', 4, 'DONE');
INSERT INTO `trx_lkh` VALUES (3, 'Februari 2018', 1, '2018-02-01', '2018-02-28', 2, 4, 41, '2018-04-16', '2018-04-16 18:07:52', 1, '2018-04-20 22:33:43', 1, 'EXAM');
INSERT INTO `trx_lkh` VALUES (4, 'Januari 2018', 1, '2018-01-01', '2018-01-31', 2, 4, 41, '2018-04-16', '2018-04-16 18:23:03', 1, '2018-04-21 18:21:30', 1, 'EXAM');
INSERT INTO `trx_lkh` VALUES (5, 'April 2018', 4, '2018-04-01', '2018-04-30', 2, 3, 41, '2018-04-17', '2018-04-17 16:31:24', 4, '2018-04-18 00:46:24', 4, 'TODO');
INSERT INTO `trx_lkh` VALUES (7, 'April 2018', 1, '2018-04-01', '2018-04-30', 2, 4, 41, '2018-04-18', '2018-04-18 04:22:46', 1, '2018-04-21 00:18:19', 1, 'EXAM');
INSERT INTO `trx_lkh` VALUES (8, 'Mei 2018', 1, '2018-05-01', '2018-05-31', 2, 4, 41, '2018-04-18', '2018-04-18 04:23:10', 1, '2018-04-21 18:23:31', 1, 'EXAM');
INSERT INTO `trx_lkh` VALUES (9, 'Juni 2018', 1, '2018-06-01', '2018-06-30', 2, 4, 41, '2018-04-18', '2018-04-18 04:27:08', 1, '2018-04-18 04:27:08', 1, 'TODO');
INSERT INTO `trx_lkh` VALUES (10, 'Juli 2018', 1, '2018-07-01', '2018-07-31', 3, 4, 41, '2018-04-18', '2018-04-18 04:27:27', 1, '2018-04-18 04:27:27', 1, 'TODO');
INSERT INTO `trx_lkh` VALUES (11, 'Agustus 2018', 1, '2018-08-01', '2018-08-31', NULL, NULL, 41, '2018-04-18', '2018-04-18 04:28:10', 1, '2018-04-18 04:28:10', 1, 'TODO');
INSERT INTO `trx_lkh` VALUES (12, 'September 2018', 1, '2018-09-01', '2018-09-30', NULL, NULL, 41, '2018-04-18', '2018-04-18 04:28:37', 1, '2018-04-18 04:28:37', 1, 'TODO');
INSERT INTO `trx_lkh` VALUES (13, 'Oktober 2018', 1, '2018-10-01', '2018-10-31', NULL, NULL, 41, '2018-04-18', '2018-04-18 04:28:51', 1, '2018-04-18 04:28:51', 1, 'TODO');
INSERT INTO `trx_lkh` VALUES (16, 'November 2018', 1, '2018-11-01', '2018-11-30', NULL, NULL, 41, '2018-04-18', '2018-04-18 04:36:43', 1, '2018-04-18 04:36:43', 1, 'TODO');
INSERT INTO `trx_lkh` VALUES (17, 'Desember 2018', 1, '2018-12-01', '2018-12-31', NULL, NULL, 41, '2018-04-18', '2018-04-18 04:36:56', 1, '2018-04-18 04:36:56', 1, 'TODO');
INSERT INTO `trx_lkh` VALUES (18, 'April 2018', 16, '2018-04-01', '2018-04-30', 2, 4, 41, '2018-04-19', '2018-04-19 02:46:45', 16, '2018-04-19 02:46:45', 16, 'TODO');

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
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_lkh_days
-- ----------------------------
INSERT INTO `trx_lkh_days` VALUES (13, NULL, 2, '2018-03-31', 0, '2018-04-16 14:42:04', 1);
INSERT INTO `trx_lkh_days` VALUES (14, NULL, 3, '2018-02-01', 0, '2018-04-16 18:08:02', 1);
INSERT INTO `trx_lkh_days` VALUES (15, NULL, 3, '2018-02-02', 0, '2018-04-16 18:12:52', 1);
INSERT INTO `trx_lkh_days` VALUES (16, NULL, 3, '2018-02-03', 0, '2018-04-16 18:13:26', 1);
INSERT INTO `trx_lkh_days` VALUES (26, NULL, 5, '2018-04-18', 0, '2018-04-18 00:04:40', 4);
INSERT INTO `trx_lkh_days` VALUES (27, NULL, 4, '2018-01-01', 1, '2018-04-18 22:35:21', 1);
INSERT INTO `trx_lkh_days` VALUES (28, NULL, 4, '2018-01-02', 1, '2018-04-18 22:35:44', 1);
INSERT INTO `trx_lkh_days` VALUES (29, NULL, 4, '2018-01-03', 1, '2018-04-18 22:35:55', 1);
INSERT INTO `trx_lkh_days` VALUES (30, NULL, 4, '2018-01-04', 1, '2018-04-18 22:36:09', 1);
INSERT INTO `trx_lkh_days` VALUES (31, NULL, 4, '2018-01-06', 1, '2018-04-18 22:37:00', 1);
INSERT INTO `trx_lkh_days` VALUES (32, NULL, 18, '2018-04-01', 1, '2018-04-19 02:50:29', 16);
INSERT INTO `trx_lkh_days` VALUES (33, NULL, 18, '2018-04-19', 1, '2018-04-19 02:53:27', 16);
INSERT INTO `trx_lkh_days` VALUES (34, NULL, 17, '2018-12-01', 0, '2018-04-19 14:18:38', 1);
INSERT INTO `trx_lkh_days` VALUES (35, NULL, 7, '2018-04-21', 0, '2018-04-21 00:15:44', 1);
INSERT INTO `trx_lkh_days` VALUES (36, NULL, 7, '2018-04-20', 1, '2018-04-21 00:22:58', 1);
INSERT INTO `trx_lkh_days` VALUES (37, NULL, 7, '2018-04-01', 1, '2018-04-21 00:49:09', 1);

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
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_lkh_exams
-- ----------------------------
INSERT INTO `trx_lkh_exams` VALUES (4, 2, 4, '2018-04-16', 'EXAM', 'OK');
INSERT INTO `trx_lkh_exams` VALUES (5, 2, 4, '2018-04-16', 'DONE', 'OK');
INSERT INTO `trx_lkh_exams` VALUES (6, 4, 4, '2018-04-16', 'TODO', '');
INSERT INTO `trx_lkh_exams` VALUES (7, 3, 4, '2018-04-16', 'TODO', '');
INSERT INTO `trx_lkh_exams` VALUES (8, 4, 4, '2018-04-16', 'TODO', '');

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for trx_lkh_items
-- ----------------------------
DROP TABLE IF EXISTS `trx_lkh_items`;
CREATE TABLE `trx_lkh_items`  (
  `lki_id` int(11) NOT NULL AUTO_INCREMENT,
  `lki_lkd_id` int(11) NULL DEFAULT NULL,
  `lki_desc` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `lki_ti_id` int(11) NULL DEFAULT NULL,
  `lki_volume` int(11) NULL DEFAULT NULL,
  `lki_unit` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `lki_cost` double(15, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`lki_id`) USING BTREE,
  INDEX `lki_idx_0`(`lki_lkd_id`, `lki_ti_id`) USING BTREE,
  INDEX `lki_idx_1`(`lki_unit`, `lki_lkd_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 117 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_lkh_items
-- ----------------------------
INSERT INTO `trx_lkh_items` VALUES (43, 13, 'Menyusun laporan SKP 2018', 3, 1, 'dokumen', NULL);
INSERT INTO `trx_lkh_items` VALUES (44, 13, 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua', 1, 1, 'dokumen', 50000.00);
INSERT INTO `trx_lkh_items` VALUES (45, 14, 'A', 4, 1, 'peserta', NULL);
INSERT INTO `trx_lkh_items` VALUES (46, 14, 'B', 5, 1, 'dokumen', NULL);
INSERT INTO `trx_lkh_items` VALUES (47, 14, 'C', 6, 1, 'dokumen', NULL);
INSERT INTO `trx_lkh_items` VALUES (48, 15, 'FOO', 7, 1, 'dokumen', NULL);
INSERT INTO `trx_lkh_items` VALUES (49, 15, 'BAR', 8, 1, 'dokumen', NULL);
INSERT INTO `trx_lkh_items` VALUES (50, 16, 'BAZ', 9, 1, 'dokumen', NULL);
INSERT INTO `trx_lkh_items` VALUES (99, 27, 'Koreksi dan Diskusi Pembuatan SK', 11, 1, 'dokumen', NULL);
INSERT INTO `trx_lkh_items` VALUES (100, 27, 'Finalisasi Bahan Sosialisasi Produk Kediklatan', 12, 1, 'dokumen', NULL);
INSERT INTO `trx_lkh_items` VALUES (101, 28, 'Melakukan Survey Penyusunan Indek Mutu Diklat Di BDK Bandung', 13, 1, 'dokumen', NULL);
INSERT INTO `trx_lkh_items` VALUES (102, 29, 'Melakukan Survey Penyusunan Indek Mutu Diklat Di BDK Bandung', 13, 1, 'dokumen', NULL);
INSERT INTO `trx_lkh_items` VALUES (103, 30, 'Melakukan Survey Penyusunan Indek Mutu Diklat Di BDK Bandung', 13, 1, 'dokumen', NULL);
INSERT INTO `trx_lkh_items` VALUES (104, 31, 'Mengikuti Fullday Penyusunan/Pengembangan Kurikulum Silabus Diklat Teknis Administrasi pada Lembaga Pendidikan (Tahap Pembahasan)', 14, 1, 'dokumen', NULL);
INSERT INTO `trx_lkh_items` VALUES (105, 32, 'Melakukan Survey Penyusunan Indek Mutu Diklat Di BDK Bandung', 15, 1, 'dokumen', 2500000.00);
INSERT INTO `trx_lkh_items` VALUES (107, 33, 'Mengikuti Fullday Penyusunan/Pengembangan Kurikulum Silabus Diklat Teknis Administrasi pada Lembaga Pendidikan (Tahap Pembahasan)', 16, 1, 'dokumen', NULL);
INSERT INTO `trx_lkh_items` VALUES (109, 36, 'Membaca', 18, 1, '', NULL);
INSERT INTO `trx_lkh_items` VALUES (110, 37, 'Libur', 17, NULL, '', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_lkh_statuses
-- ----------------------------
INSERT INTO `trx_lkh_statuses` VALUES (2, 2, 780, 938, 'proses-lkh', 1, '2018-04-16 14:09:40');
INSERT INTO `trx_lkh_statuses` VALUES (7, 2, 759, 939, 'proses-lkh', 1, '2018-04-16 17:02:53');
INSERT INTO `trx_lkh_statuses` VALUES (8, 2, 792, 954, 'proses-lkh', 0, '2018-04-16 17:17:28');
INSERT INTO `trx_lkh_statuses` VALUES (9, 3, 780, 938, 'proses-lkh', 1, '2018-04-16 18:07:52');
INSERT INTO `trx_lkh_statuses` VALUES (10, 4, 780, 938, 'proses-lkh', 1, '2018-04-16 18:23:03');
INSERT INTO `trx_lkh_statuses` VALUES (11, 4, 759, 939, 'proses-lkh', 1, '2018-04-16 18:42:04');
INSERT INTO `trx_lkh_statuses` VALUES (12, 4, 795, 938, 'proses-lkh', 1, '2018-04-16 18:42:26');
INSERT INTO `trx_lkh_statuses` VALUES (13, 3, 759, 939, 'proses-lkh', 1, '2018-04-16 18:42:46');
INSERT INTO `trx_lkh_statuses` VALUES (14, 3, 795, 938, 'proses-lkh', 1, '2018-04-16 18:43:21');
INSERT INTO `trx_lkh_statuses` VALUES (15, 4, 759, 939, 'proses-lkh', 1, '2018-04-16 18:47:09');
INSERT INTO `trx_lkh_statuses` VALUES (16, 4, 795, 938, 'proses-lkh', 1, '2018-04-16 18:47:23');
INSERT INTO `trx_lkh_statuses` VALUES (17, 3, 759, 939, 'proses-lkh', 0, '2018-04-16 18:49:08');
INSERT INTO `trx_lkh_statuses` VALUES (18, 5, 780, 938, 'proses-lkh', 0, '2018-04-17 16:31:24');
INSERT INTO `trx_lkh_statuses` VALUES (20, 7, 780, 938, 'proses-lkh', 1, '2018-04-18 04:22:46');
INSERT INTO `trx_lkh_statuses` VALUES (21, 8, 780, 938, 'proses-lkh', 1, '2018-04-18 04:23:10');
INSERT INTO `trx_lkh_statuses` VALUES (22, 9, 780, 938, 'proses-lkh', 0, '2018-04-18 04:27:08');
INSERT INTO `trx_lkh_statuses` VALUES (23, 10, 780, 938, 'proses-lkh', 0, '2018-04-18 04:27:27');
INSERT INTO `trx_lkh_statuses` VALUES (24, 11, 780, 938, 'proses-lkh', 0, '2018-04-18 04:28:10');
INSERT INTO `trx_lkh_statuses` VALUES (25, 12, 780, 938, 'proses-lkh', 0, '2018-04-18 04:28:37');
INSERT INTO `trx_lkh_statuses` VALUES (26, 13, 780, 938, 'proses-lkh', 0, '2018-04-18 04:28:51');
INSERT INTO `trx_lkh_statuses` VALUES (29, 16, 780, 938, 'proses-lkh', 0, '2018-04-18 04:36:43');
INSERT INTO `trx_lkh_statuses` VALUES (30, 17, 780, 938, 'proses-lkh', 0, '2018-04-18 04:36:56');
INSERT INTO `trx_lkh_statuses` VALUES (31, 18, 780, 938, 'proses-lkh', 0, '2018-04-19 02:46:45');
INSERT INTO `trx_lkh_statuses` VALUES (32, 7, 759, 939, 'proses-lkh', 0, '2018-04-21 00:18:19');
INSERT INTO `trx_lkh_statuses` VALUES (33, 4, 759, 939, 'proses-lkh', 0, '2018-04-21 18:21:30');
INSERT INTO `trx_lkh_statuses` VALUES (34, 8, 759, 939, 'proses-lkh', 0, '2018-04-21 18:23:31');

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
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_lkh_users
-- ----------------------------
INSERT INTO `trx_lkh_users` VALUES (5, 2, 1);
INSERT INTO `trx_lkh_users` VALUES (6, 2, 3);
INSERT INTO `trx_lkh_users` VALUES (7, 2, 4);
INSERT INTO `trx_lkh_users` VALUES (8, 3, 1);
INSERT INTO `trx_lkh_users` VALUES (9, 3, 2);
INSERT INTO `trx_lkh_users` VALUES (10, 3, 4);
INSERT INTO `trx_lkh_users` VALUES (11, 4, 1);
INSERT INTO `trx_lkh_users` VALUES (12, 4, 2);
INSERT INTO `trx_lkh_users` VALUES (13, 4, 4);
INSERT INTO `trx_lkh_users` VALUES (15, 5, 1);
INSERT INTO `trx_lkh_users` VALUES (16, 5, 2);
INSERT INTO `trx_lkh_users` VALUES (17, 5, 3);
INSERT INTO `trx_lkh_users` VALUES (14, 5, 4);
INSERT INTO `trx_lkh_users` VALUES (23, 7, 1);
INSERT INTO `trx_lkh_users` VALUES (24, 7, 2);
INSERT INTO `trx_lkh_users` VALUES (25, 7, 4);
INSERT INTO `trx_lkh_users` VALUES (26, 8, 1);
INSERT INTO `trx_lkh_users` VALUES (27, 8, 2);
INSERT INTO `trx_lkh_users` VALUES (28, 8, 4);
INSERT INTO `trx_lkh_users` VALUES (29, 9, 1);
INSERT INTO `trx_lkh_users` VALUES (30, 9, 2);
INSERT INTO `trx_lkh_users` VALUES (31, 9, 4);
INSERT INTO `trx_lkh_users` VALUES (32, 10, 1);
INSERT INTO `trx_lkh_users` VALUES (33, 10, 3);
INSERT INTO `trx_lkh_users` VALUES (34, 10, 4);
INSERT INTO `trx_lkh_users` VALUES (35, 11, 1);
INSERT INTO `trx_lkh_users` VALUES (36, 12, 1);
INSERT INTO `trx_lkh_users` VALUES (37, 13, 1);
INSERT INTO `trx_lkh_users` VALUES (40, 16, 1);
INSERT INTO `trx_lkh_users` VALUES (41, 17, 1);
INSERT INTO `trx_lkh_users` VALUES (43, 18, 1);
INSERT INTO `trx_lkh_users` VALUES (44, 18, 2);
INSERT INTO `trx_lkh_users` VALUES (45, 18, 4);
INSERT INTO `trx_lkh_users` VALUES (42, 18, 16);

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
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_presence
-- ----------------------------
INSERT INTO `trx_presence` VALUES (1, '2018-03-05', 1, 'Masuk', '07.45', NULL, NULL, NULL, NULL, 47, NULL, '2018-03-05 04:20:13', 1, '2018-03-05 04:20:13', 1);
INSERT INTO `trx_presence` VALUES (2, '2018-03-05', 25, 'Alfa', '07.10', NULL, '', 'image/jpeg', NULL, 47, NULL, '2018-03-05 18:51:52', 1, '2018-03-05 21:03:31', 1);
INSERT INTO `trx_presence` VALUES (3, '2018-03-06', 1, 'Sakit', '07.45', NULL, 'f8cff61bb7d7427c8c6dfb2066ca4d6d.jpg', 'image/jpeg', NULL, 47, '2018-03-05', '2018-03-05 19:41:21', 1, '2018-03-05 21:03:24', 1);
INSERT INTO `trx_presence` VALUES (4, '2018-03-05', 16, 'Dinas Luar', '07.00', NULL, 'bd0eb534420b4d87b24c5ec9211b8f00.jpg', 'image/jpeg', NULL, 47, '2018-03-05', '2018-03-05 21:04:54', 1, '2018-03-07 20:28:15', 1);
INSERT INTO `trx_presence` VALUES (5, '2018-03-07', 4, 'Izin', NULL, NULL, '93e3d435fdd348bebb24bc43ed6ffd30.jpg', 'image/jpeg', NULL, 47, '2018-03-07', '2018-03-07 20:29:42', 1, '2018-03-07 20:29:42', 1);
INSERT INTO `trx_presence` VALUES (6, '2018-03-07', 3, 'Sakit', NULL, NULL, NULL, NULL, NULL, 47, '2018-03-07', '2018-03-07 22:53:47', 1, '2018-03-07 22:53:47', 1);
INSERT INTO `trx_presence` VALUES (7, '2018-03-09', 1, 'Masuk', '7.45', NULL, NULL, NULL, NULL, 47, '2018-03-09', '2018-03-09 13:08:25', 1, '2018-03-09 13:08:25', 1);

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
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_presence_statuses
-- ----------------------------
INSERT INTO `trx_presence_statuses` VALUES (1, 1, 781, 951, 'proses-absensi', 0, '2018-03-05 04:20:13');
INSERT INTO `trx_presence_statuses` VALUES (2, 2, 781, 951, 'proses-absensi', 0, '2018-03-05 18:51:52');
INSERT INTO `trx_presence_statuses` VALUES (3, 3, 781, 951, 'proses-absensi', 0, '2018-03-05 19:41:21');
INSERT INTO `trx_presence_statuses` VALUES (4, 4, 781, 951, 'proses-absensi', 0, '2018-03-05 21:04:54');
INSERT INTO `trx_presence_statuses` VALUES (5, 5, 781, 951, 'proses-absensi', 0, '2018-03-07 20:29:42');
INSERT INTO `trx_presence_statuses` VALUES (6, 6, 781, 951, 'proses-absensi', 0, '2018-03-07 22:53:47');
INSERT INTO `trx_presence_statuses` VALUES (7, 7, 781, 951, 'proses-absensi', 0, '2018-03-09 13:08:25');

-- ----------------------------
-- Table structure for trx_presence_types
-- ----------------------------
DROP TABLE IF EXISTS `trx_presence_types`;
CREATE TABLE `trx_presence_types`  (
  `tpt_id` int(11) NOT NULL AUTO_INCREMENT,
  `tpt_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tpt_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_presence_types
-- ----------------------------
INSERT INTO `trx_presence_types` VALUES (1, 'Masuk');
INSERT INTO `trx_presence_types` VALUES (2, 'Izin');
INSERT INTO `trx_presence_types` VALUES (3, 'Sakit');
INSERT INTO `trx_presence_types` VALUES (4, 'Alfa');
INSERT INTO `trx_presence_types` VALUES (5, 'Dinas Luar');
INSERT INTO `trx_presence_types` VALUES (6, 'Lain-lain');

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
  `skp_superior` int(11) NULL DEFAULT NULL,
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
  `skp_report_dt` date NULL DEFAULT NULL,
  `skp_receive_dt` date NULL DEFAULT NULL,
  `skp_created_dt` datetime(0) NULL DEFAULT NULL,
  `skp_created_by` int(11) NULL DEFAULT NULL,
  `skp_updated_dt` datetime(0) NULL DEFAULT NULL,
  `skp_updated_by` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`skp_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_skp
-- ----------------------------
INSERT INTO `trx_skp` VALUES (5, 'Januari s/d Desember 2018', '2018-01-01', '2018-12-31', 16, 40, '2018-03-22', 'VERIFICATION', 4, 2, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2018-03-22 20:26:30', 16, '2018-03-26 03:35:11', 1);
INSERT INTO `trx_skp` VALUES (8, 'Januari s/d Desember 2018', '2018-01-01', '2018-12-31', 1, 40, '2018-03-26', NULL, NULL, NULL, NULL, 0.00, '', 0.00, NULL, NULL, NULL, 0.00, 0.00, '', 'PENILAIAN PRESTASI KERJA', 'PEGAWAI NEGERI SIPIL', 'PUSDIKLAT TENAGA ADMINISTRASI', 'TAHUN 2018', NULL, NULL, '2018-03-26 13:50:05', 1, '2018-04-08 15:20:52', 1);

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
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_skp_behaviors
-- ----------------------------
INSERT INTO `trx_skp_behaviors` VALUES (1, 5, 1, 1.00, 'Buruk');
INSERT INTO `trx_skp_behaviors` VALUES (2, 5, 2, NULL, 'Buruk');
INSERT INTO `trx_skp_behaviors` VALUES (3, 5, 3, NULL, 'Buruk');
INSERT INTO `trx_skp_behaviors` VALUES (4, 5, 4, NULL, 'Buruk');
INSERT INTO `trx_skp_behaviors` VALUES (5, 5, 5, NULL, 'Buruk');
INSERT INTO `trx_skp_behaviors` VALUES (6, 5, 6, NULL, '');

-- ----------------------------
-- Table structure for trx_skp_items
-- ----------------------------
DROP TABLE IF EXISTS `trx_skp_items`;
CREATE TABLE `trx_skp_items`  (
  `ski_id` int(11) NOT NULL AUTO_INCREMENT,
  `ski_skp_id` int(11) NULL DEFAULT NULL,
  `ski_desc` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ski_volume` int(11) NULL DEFAULT NULL,
  `ski_volume_real` int(11) NULL DEFAULT NULL,
  `ski_unit` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ski_cost` double(15, 2) NULL DEFAULT NULL,
  `ski_cost_real` double(15, 2) NULL DEFAULT NULL,
  `ski_duration` int(11) NULL DEFAULT NULL,
  `ski_duration_real` int(11) NULL DEFAULT NULL,
  `ski_duration_unit` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ski_quality` int(11) NULL DEFAULT NULL,
  `ski_quality_real` int(11) NULL DEFAULT NULL,
  `ski_ak` int(11) NULL DEFAULT NULL,
  `ski_ak_real` int(11) NULL DEFAULT NULL,
  `ski_ak_factor` int(11) NULL DEFAULT NULL,
  `ski_extra` int(1) NULL DEFAULT 0,
  `ski_total` double(15, 2) NULL DEFAULT NULL,
  `ski_performance` double(15, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`ski_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 55 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_skp_items
-- ----------------------------
INSERT INTO `trx_skp_items` VALUES (52, 8, 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua', NULL, NULL, 'dokumen', NULL, NULL, NULL, NULL, 'bulan', NULL, NULL, NULL, NULL, NULL, 0, -24.00, -8.00);
INSERT INTO `trx_skp_items` VALUES (53, 8, 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua', NULL, NULL, 'dokumen', NULL, NULL, NULL, NULL, 'bulan', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `trx_skp_items` VALUES (54, 8, 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua', NULL, NULL, 'dokumen', NULL, NULL, NULL, NULL, 'bulan', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL);

-- ----------------------------
-- Table structure for trx_skp_labels
-- ----------------------------
DROP TABLE IF EXISTS `trx_skp_labels`;
CREATE TABLE `trx_skp_labels`  (
  `skl_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `skl_skp_id` bigint(20) NULL DEFAULT NULL,
  `skl_sl_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`skl_id`) USING BTREE
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
  PRIMARY KEY (`sks_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_skp_statuses
-- ----------------------------
INSERT INTO `trx_skp_statuses` VALUES (10, 5, 712, 905, 'proses-skp', 1, '2018-03-22 20:26:30');
INSERT INTO `trx_skp_statuses` VALUES (19, 5, 770, 947, 'proses-skp', 1, '2018-03-26 03:34:44');
INSERT INTO `trx_skp_statuses` VALUES (20, 5, 791, 956, 'proses-skp', 1, '2018-03-26 03:34:55');
INSERT INTO `trx_skp_statuses` VALUES (21, 5, 794, 957, 'proses-skp', 0, '2018-03-26 03:35:11');
INSERT INTO `trx_skp_statuses` VALUES (22, 8, 712, 905, 'proses-skp', 0, '2018-03-26 13:50:05');

-- ----------------------------
-- Table structure for trx_skp_users
-- ----------------------------
DROP TABLE IF EXISTS `trx_skp_users`;
CREATE TABLE `trx_skp_users`  (
  `sku_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sku_skp_id` bigint(20) NULL DEFAULT NULL,
  `sku_su_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`sku_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_skp_users
-- ----------------------------
INSERT INTO `trx_skp_users` VALUES (1, 5, 16);
INSERT INTO `trx_skp_users` VALUES (2, 5, 1);
INSERT INTO `trx_skp_users` VALUES (3, 5, 4);
INSERT INTO `trx_skp_users` VALUES (4, 5, 2);
INSERT INTO `trx_skp_users` VALUES (5, 5, 3);
INSERT INTO `trx_skp_users` VALUES (21, 8, 1);

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
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_tasks
-- ----------------------------
INSERT INTO `trx_tasks` VALUES (1, 'Administrator - 30 Jan 2018', 'Tahap Absensi', 41, NULL, '2018-01-30', 1, '2018-01-30 23:56:43', '2018-01-30 23:57:01', 1);
INSERT INTO `trx_tasks` VALUES (2, 'Administrator - 30 Jan 2018', NULL, 45, NULL, '2018-12-31', 1, '2018-01-30 23:57:01', '2018-01-31 15:24:01', 1);
INSERT INTO `trx_tasks` VALUES (12, 'Administrator - 02 Feb 2018', 'Tahap Absensi', 41, NULL, '2018-02-02', 1, '2018-02-02 00:31:47', '2018-02-02 00:31:47', 1);
INSERT INTO `trx_tasks` VALUES (13, 'Administrator - 03 Feb 2018', 'Tahap Absensi', 41, NULL, '2018-02-02', 1, '2018-02-02 00:34:28', '2018-02-02 00:34:28', 1);
INSERT INTO `trx_tasks` VALUES (14, 'Administrator - 04 Feb 2018', 'Tahap Absensi', 41, NULL, '2018-02-02', 1, '2018-02-02 00:34:44', '2018-02-02 00:34:44', 1);
INSERT INTO `trx_tasks` VALUES (15, 'Administrator - 05 Feb 2018', 'Tahap Absensi', 41, NULL, '2018-02-02', 1, '2018-02-02 00:34:56', '2018-02-02 00:34:56', 1);
INSERT INTO `trx_tasks` VALUES (16, 'Administrator - 06 Feb 2018', 'Tahap Absensi', 41, NULL, '2018-02-02', 1, '2018-02-02 00:35:25', '2018-02-02 00:35:25', 1);

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
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_tasks_activities
-- ----------------------------
INSERT INTO `trx_tasks_activities` VALUES (1, NULL, 'comment', 1, '2018-03-05 18:36:18', '<p>Ok</p>', NULL);
INSERT INTO `trx_tasks_activities` VALUES (2, NULL, 'comment', 1, '2018-03-20 00:02:42', '<p>Tanggal 23 belum diisi</p>', NULL);
INSERT INTO `trx_tasks_activities` VALUES (3, NULL, 'comment', 1, '2018-03-20 00:19:33', '<p>xxx</p>', NULL);
INSERT INTO `trx_tasks_activities` VALUES (4, NULL, 'comment', 1, '2018-03-20 00:19:44', '<p>xxx</p>', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_tasks_statuses
-- ----------------------------
INSERT INTO `trx_tasks_statuses` VALUES (1, 1, 756, 937, 'proses-lkh', 1, '|tpr_id=1|tpr_date=2018-01-30|tpr_su_id=1|tpr_type=Masuk|tpr_checkin=23.56|tpr_checkout=null|tpr_file=-|tpr_desc=-|tpr_date_formatted=30 Jan 2018|tpr_su_fullname=Administrator|tpr_su_sj_name=Jabatan Fungsional Umum|tpr_su_sdp_name=Badan Litbang dan Diklat Kementerian Agama|date=2018-01-30|author=1|', '<iron-icon icon=\"label-outline\"></iron-icon>&nbsp;Masuk&nbsp;( 23.56 )', 1, '2018-01-30 23:56:43');
INSERT INTO `trx_tasks_statuses` VALUES (2, 1, 758, 938, 'proses-lkh', 1, '|tpr_id=1|tpr_date=2018-01-30|tpr_su_id=1|tpr_type=Masuk|tpr_checkin=23.56|tpr_checkout=null|tpr_file=-|tpr_desc=-|tpr_date_formatted=30 Jan 2018|tpr_su_fullname=Administrator|tpr_su_sj_name=Jabatan Fungsional Umum|tpr_su_sdp_name=Badan Litbang dan Diklat Kementerian Agama|date=2018-01-30|author=1|', '<iron-icon icon=\"label-outline\"></iron-icon>&nbsp;Masuk&nbsp;( 23.56 )', 1, '2018-01-30 23:56:50');
INSERT INTO `trx_tasks_statuses` VALUES (3, 2, 760, 946, 'proses-cek-lkh', 1, '|date=2018-01-30|author=1|lkh_id=1|lkh_tpr_id=1|lkh_date=2018-01-30|lkh_su_id=1|lkh_volume=1|lkh_desc=|lkh_created_dt=2018-01-30 23:56:49|lkh_created_by=1|lkh_exam_id=45|lkh_ticket=1|lkh_validation=0|lkh_date_formatted=30 Jan 2018|lkh_su_fullname=Administrator|lkh_su_no=197109012005012005|lkh_su_grade=Penata, III/C|lkh_su_sj_name=Jabatan Fungsional Umum|lkh_su_sdp_name=Badan Litbang dan Diklat Kementerian Agama|lkh_tpr_date=2018-01-30|lkh_tpr_su_id=1|lkh_tpr_type=Masuk|lkh_tpr_checkin=23.56|lkh_tpr_checkout=|lkh_tpr_file=-|lkh_tpr_desc=-|lkh_tpr_date_formatted=30 Jan 2018|lkh_tpr_su_fullname=Administrator|lkh_tpr_su_sj_name=Jabatan Fungsional Umum|lkh_tpr_su_sdp_name=Badan Litbang dan Diklat Kementerian Agama|', '', 1, '2018-01-30 23:57:01');
INSERT INTO `trx_tasks_statuses` VALUES (4, 1, 759, 939, 'proses-lkh', 1, '|lkh_id=1|lkh_tpr_id=1|lkh_date=2018-01-30|lkh_su_id=1|lkh_volume=1|lkh_desc=|lkh_created_dt=2018-01-30 23:56:49|lkh_created_by=1|lkh_exam_id=45|lkh_ticket=1|lkh_validation=0|lkh_date_formatted=30 Jan 2018|lkh_su_fullname=Administrator|lkh_su_no=197109012005012005|lkh_su_grade=Penata, III/C|lkh_su_sj_name=Jabatan Fungsional Umum|lkh_su_sdp_name=Badan Litbang dan Diklat Kementerian Agama|lkh_tpr_date=2018-01-30|lkh_tpr_su_id=1|lkh_tpr_type=Masuk|lkh_tpr_checkin=23.56|lkh_tpr_checkout=null|lkh_tpr_file=-|lkh_tpr_desc=-|lkh_tpr_date_formatted=30 Jan 2018|lkh_tpr_su_fullname=Administrator|lkh_tpr_su_sj_name=Jabatan Fungsional Umum|lkh_tpr_su_sdp_name=Badan Litbang dan Diklat Kementerian Agama|date=2018-01-30|author=1|', '<iron-icon icon=\"label-outline\"></iron-icon>&nbsp;Masuk&nbsp;( 23.56 )', 0, '2018-01-30 23:57:01');
INSERT INTO `trx_tasks_statuses` VALUES (7, 2, 764, 940, 'proses-cek-lkh', 1, '|lkh_id=1|lkh_tpr_id=1|lkh_date=2018-01-30|lkh_su_id=1|lkh_volume=1|lkh_desc=|lkh_created_dt=2018-01-30 23:56:49|lkh_created_by=1|lkh_exam_id=45|lkh_ticket=1|lkh_validation=0|lkh_flag=MD|lkh_date_formatted=30 Jan 2018|lkh_is_validating=true|lkh_is_approved=false|lkh_is_rejected=false|lkh_is_revision=false|lkh_su_fullname=Administrator|lkh_su_no=197109012005012005|lkh_su_grade=Penata, III/C|lkh_su_sj_name=Jabatan Fungsional Umum|lkh_su_sdp_name=Badan Litbang dan Diklat Kementerian Agama|lkh_tpr_date=2018-01-30|lkh_tpr_su_id=1|lkh_tpr_type=Masuk|lkh_tpr_checkin=23.56|lkh_tpr_checkout=null|lkh_tpr_file=-|lkh_tpr_desc=-|lkh_tpr_date_formatted=30 Jan 2018|lkh_tpr_su_fullname=Administrator|lkh_tpr_su_sj_name=Jabatan Fungsional Umum|lkh_tpr_su_sdp_name=Badan Litbang dan Diklat Kementerian Agama|date=2018-01-30|author=1|', '', 0, '2018-01-31 15:24:01');
INSERT INTO `trx_tasks_statuses` VALUES (8, 2, 767, 941, 'proses-cek-lkh', 1, '|lkh_id=1|lkh_tpr_id=1|lkh_date=2018-01-30|lkh_su_id=1|lkh_volume=1|lkh_desc=|lkh_created_dt=2018-01-30 23:56:49|lkh_created_by=1|lkh_exam_id=45|lkh_ticket=1|lkh_validation=0|lkh_flag=MD|lkh_date_formatted=30 Jan 2018|lkh_is_validating=true|lkh_is_approved=false|lkh_is_rejected=false|lkh_is_revision=false|lkh_su_fullname=Administrator|lkh_su_no=197109012005012005|lkh_su_grade=Penata, III/C|lkh_su_sj_name=Jabatan Fungsional Umum|lkh_su_sdp_name=Badan Litbang dan Diklat Kementerian Agama|lkh_tpr_date=2018-01-30|lkh_tpr_su_id=1|lkh_tpr_type=Masuk|lkh_tpr_checkin=23.56|lkh_tpr_checkout=null|lkh_tpr_file=-|lkh_tpr_desc=-|lkh_tpr_date_formatted=30 Jan 2018|lkh_tpr_su_fullname=Administrator|lkh_tpr_su_sj_name=Jabatan Fungsional Umum|lkh_tpr_su_sdp_name=Badan Litbang dan Diklat Kementerian Agama|date=2018-01-30|author=1|', '', 0, '2018-01-31 15:24:01');
INSERT INTO `trx_tasks_statuses` VALUES (9, 2, 769, 942, 'proses-cek-lkh', 1, '|lkh_id=1|lkh_tpr_id=1|lkh_date=2018-01-30|lkh_su_id=1|lkh_volume=1|lkh_desc=|lkh_created_dt=2018-01-30 23:56:49|lkh_created_by=1|lkh_exam_id=45|lkh_ticket=1|lkh_validation=0|lkh_flag=MD|lkh_date_formatted=30 Jan 2018|lkh_is_validating=true|lkh_is_approved=false|lkh_is_rejected=false|lkh_is_revision=false|lkh_su_fullname=Administrator|lkh_su_no=197109012005012005|lkh_su_grade=Penata, III/C|lkh_su_sj_name=Jabatan Fungsional Umum|lkh_su_sdp_name=Badan Litbang dan Diklat Kementerian Agama|lkh_tpr_date=2018-01-30|lkh_tpr_su_id=1|lkh_tpr_type=Masuk|lkh_tpr_checkin=23.56|lkh_tpr_checkout=null|lkh_tpr_file=-|lkh_tpr_desc=-|lkh_tpr_date_formatted=30 Jan 2018|lkh_tpr_su_fullname=Administrator|lkh_tpr_su_sj_name=Jabatan Fungsional Umum|lkh_tpr_su_sdp_name=Badan Litbang dan Diklat Kementerian Agama|date=2018-01-30|author=1|', '', 0, '2018-01-31 15:24:01');
INSERT INTO `trx_tasks_statuses` VALUES (19, 12, 756, 937, 'proses-lkh', 11, '|tpr_id=11|tpr_date=2018-02-02|tpr_su_id=1|tpr_type=Masuk|tpr_checkin=00.31|tpr_checkout=null|tpr_file=-|tpr_desc=-|tpr_date_formatted=02 Feb 2018|tpr_su_fullname=Administrator|tpr_su_sj_name=Jabatan Fungsional Umum|tpr_su_sdp_name=Badan Litbang dan Diklat Kementerian Agama|date=2018-02-02|author=1|', '<iron-icon icon=\"label-outline\"></iron-icon>&nbsp;Masuk&nbsp;( 00.31 )', 0, '2018-02-02 00:31:48');
INSERT INTO `trx_tasks_statuses` VALUES (20, 13, 756, 937, 'proses-lkh', 12, '|tpr_id=12|tpr_date=2018-02-03|tpr_su_id=1|tpr_type=Masuk|tpr_checkin=00.34|tpr_checkout=null|tpr_file=-|tpr_desc=-|tpr_date_formatted=03 Feb 2018|tpr_su_fullname=Administrator|tpr_su_sj_name=Jabatan Fungsional Umum|tpr_su_sdp_name=Badan Litbang dan Diklat Kementerian Agama|date=2018-02-03|author=1|', '<iron-icon icon=\"label-outline\"></iron-icon>&nbsp;Masuk&nbsp;( 00.34 )', 0, '2018-02-02 00:34:28');
INSERT INTO `trx_tasks_statuses` VALUES (21, 14, 756, 937, 'proses-lkh', 13, '|tpr_id=13|tpr_date=2018-02-04|tpr_su_id=1|tpr_type=Masuk|tpr_checkin=00.34|tpr_checkout=null|tpr_file=-|tpr_desc=-|tpr_date_formatted=04 Feb 2018|tpr_su_fullname=Administrator|tpr_su_sj_name=Jabatan Fungsional Umum|tpr_su_sdp_name=Badan Litbang dan Diklat Kementerian Agama|date=2018-02-04|author=1|', '<iron-icon icon=\"label-outline\"></iron-icon>&nbsp;Masuk&nbsp;( 00.34 )', 0, '2018-02-02 00:34:44');
INSERT INTO `trx_tasks_statuses` VALUES (22, 15, 756, 937, 'proses-lkh', 14, '|tpr_id=14|tpr_date=2018-02-05|tpr_su_id=1|tpr_type=Masuk|tpr_checkin=00.34|tpr_checkout=null|tpr_file=-|tpr_desc=-|tpr_date_formatted=05 Feb 2018|tpr_su_fullname=Administrator|tpr_su_sj_name=Jabatan Fungsional Umum|tpr_su_sdp_name=Badan Litbang dan Diklat Kementerian Agama|date=2018-02-05|author=1|', '<iron-icon icon=\"label-outline\"></iron-icon>&nbsp;Masuk&nbsp;( 00.34 )', 0, '2018-02-02 00:34:57');
INSERT INTO `trx_tasks_statuses` VALUES (23, 16, 756, 937, 'proses-lkh', 15, '|tpr_id=15|tpr_date=2018-02-06|tpr_su_id=1|tpr_type=Masuk|tpr_checkin=00.35|tpr_checkout=null|tpr_file=-|tpr_desc=-|tpr_date_formatted=06 Feb 2018|tpr_su_fullname=Administrator|tpr_su_sj_name=Jabatan Fungsional Umum|tpr_su_sdp_name=Badan Litbang dan Diklat Kementerian Agama|date=2018-02-06|author=1|', '<iron-icon icon=\"label-outline\"></iron-icon>&nbsp;Masuk&nbsp;( 00.35 )', 0, '2018-02-02 00:35:25');

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
  PRIMARY KEY (`tus_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_users_statuses
-- ----------------------------
INSERT INTO `trx_users_statuses` VALUES (1, 23, 704, 895, 'proses-pendaftaran', 1, '2018-03-02 04:50:41');
INSERT INTO `trx_users_statuses` VALUES (2, 24, 704, 895, 'proses-pendaftaran', 1, '2018-03-03 15:12:39');
INSERT INTO `trx_users_statuses` VALUES (3, 24, 705, 896, 'proses-pendaftaran', 1, '2018-03-04 20:13:31');
INSERT INTO `trx_users_statuses` VALUES (4, 24, 706, 897, 'proses-pendaftaran', 1, '2018-03-04 20:40:04');
INSERT INTO `trx_users_statuses` VALUES (5, 24, 708, 899, 'proses-pendaftaran', 0, '2018-03-04 21:25:33');
INSERT INTO `trx_users_statuses` VALUES (6, 23, 705, 896, 'proses-pendaftaran', 1, '2018-03-04 21:26:07');
INSERT INTO `trx_users_statuses` VALUES (10, 23, 706, 897, 'proses-pendaftaran', 1, '2018-03-04 21:37:58');
INSERT INTO `trx_users_statuses` VALUES (11, 23, 708, 899, 'proses-pendaftaran', 0, '2018-03-04 21:38:54');
INSERT INTO `trx_users_statuses` VALUES (12, 25, 704, 895, 'proses-pendaftaran', 1, '2018-03-05 02:04:00');
INSERT INTO `trx_users_statuses` VALUES (13, 25, 705, 896, 'proses-pendaftaran', 1, '2018-03-05 02:04:08');
INSERT INTO `trx_users_statuses` VALUES (14, 25, 706, 897, 'proses-pendaftaran', 1, '2018-03-05 02:04:43');
INSERT INTO `trx_users_statuses` VALUES (15, 25, 708, 899, 'proses-pendaftaran', 0, '2018-03-05 02:05:08');

SET FOREIGN_KEY_CHECKS = 1;
