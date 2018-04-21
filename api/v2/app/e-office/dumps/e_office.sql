/*
 Navicat Premium Data Transfer

 Source Server         : mysql@127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 50626
 Source Host           : 127.0.0.1:3306
 Source Schema         : e_office

 Target Server Type    : MySQL
 Target Server Version : 50626
 File Encoding         : 65001

 Date: 21/04/2018 19:13:18
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
) ENGINE = InnoDB AUTO_INCREMENT = 62 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of bpm_diagrams
-- ----------------------------
INSERT INTO `bpm_diagrams` VALUES (60, 'Graph.diagram.type.Activity', 'Proses Surat Masuk', 'proses-surat-masuk', 'Bisnis proses surat masuk', '81090e3a2af1887bef00e63a3ec9659d.jpg', '2018-01-23 20:23:43', NULL);
INSERT INTO `bpm_diagrams` VALUES (61, 'Graph.diagram.type.Activity', 'Proses Surat Keluar', 'proses-surat-keluar', 'Bisnis proses surat keluar', '567412c95727334ee23a12ad6f62c249.jpg', '2018-01-23 20:25:43', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 92 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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
INSERT INTO `bpm_forms` VALUES (74, 885, 'Form Surat Masuk', 'No description', '068c4ff9d07a2ddf77ee70a7d26ab8fa.html', 'form-surat-masuk.html');
INSERT INTO `bpm_forms` VALUES (75, 886, 'Form Registrasi', 'No description', 'acc9ad12f520b4bcd329dae4a2f37e17.html', 'form-surat-masuk.html');
INSERT INTO `bpm_forms` VALUES (76, 887, 'Form Kodefikasi', 'No description', '25403b93ada83fb45e73f4185bb96331.html', 'form-surat-masuk-code.html');
INSERT INTO `bpm_forms` VALUES (77, 888, 'Form Scan', 'No description', '9dbe374b9c4a6cdd6b29c9da3aaed4f7.html', 'form-surat-masuk-scan.html');
INSERT INTO `bpm_forms` VALUES (78, 889, 'Form Surat Dibaca', 'No description', '52b3b3792709453c6931140b536c1c4e.html', 'form-surat-masuk-read.html');
INSERT INTO `bpm_forms` VALUES (79, 890, 'Form Disposisi', 'No description', 'd8b4ee90dce6643b24e60e21a6536563.html', 'form-surat-masuk-disp.html');
INSERT INTO `bpm_forms` VALUES (80, 891, 'Form Surat Keluar', 'No description', '4c6588f86e42e581b8e5041b0ff62095.html', 'form-surat-masuk-reply.html');
INSERT INTO `bpm_forms` VALUES (81, 892, 'Arsip Surat Masuk', 'No description', '59cfd4c26a9d9b46696e83c6196de324.html', 'form-surat-masuk-view.html');
INSERT INTO `bpm_forms` VALUES (82, 875, 'Form Surat Keluar', 'No description', 'e07d6adfa17e2c698422294435142b3c.html', 'form-surat-keluar.html');
INSERT INTO `bpm_forms` VALUES (83, 884, 'Form Surat Keluar', 'No description', 'd9abbde9deb2c79f14f633905d4d83e7.html', 'form-surat-keluar.html');
INSERT INTO `bpm_forms` VALUES (84, 876, 'Form Koreksi Eselon IV', 'No description', '9c19af3177790e9945fa661dbdf46d99.html', 'form-surat-keluar-exam1.html');
INSERT INTO `bpm_forms` VALUES (85, 877, 'Form Koreksi Eselon 3', 'No description', '03f2b7f57584d8fda5a38395d8728a55.html', 'form-surat-keluar-exam2.html');
INSERT INTO `bpm_forms` VALUES (86, 878, 'Form Koreksi Kapus', 'No description', '9d62ef2dabbd6a146416663687afc3c4.html', 'form-surat-keluar-exam3.html');
INSERT INTO `bpm_forms` VALUES (87, 879, 'Form Surat Keluar', 'No description', '2fc13eeee57da10b56e4da297e194d5f.html', 'form-surat-keluar-sign.html');
INSERT INTO `bpm_forms` VALUES (88, 880, 'Form Surat Keluar', 'No description', 'e5e43d17abc679c98ab1a99b6f12dfd8.html', 'form-surat-keluar-print.html');
INSERT INTO `bpm_forms` VALUES (89, 881, 'Form Surat Keluar', 'No description', '5457e4658f192c235c0c7d0d4b941ae9.html', 'form-surat-keluar-send.html');
INSERT INTO `bpm_forms` VALUES (90, 882, 'Form Surat Keluar', 'No description', '95b554a38b2f3c209231dd68fa814f8e.html', 'form-surat-keluar-confirm.html');
INSERT INTO `bpm_forms` VALUES (91, 894, 'Form Arsip Surat Keluar', 'No description', 'fef0c7acfc610c4929f3a711547585cf.html', 'form-surat-keluar-view.html');

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
) ENGINE = InnoDB AUTO_INCREMENT = 712 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of bpm_links
-- ----------------------------
INSERT INTO `bpm_links` VALUES (683, 'tahap-pembuatan', 'graph-link-1', 'graph-shape-1', 'graph-shape-10', 'Graph.link.Orthogonal', 'orthogonal', 61, 875, 884, 'M410.26361741770063,65.94179481250464L410.263617417707,138.605021554447', '#000', 'Tahap Pembuatan', 0.47307558000901, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (684, 'tahap-koreksi-eselon-iv', 'graph-link-2', 'graph-shape-10', 'graph-shape-2', 'Graph.link.Orthogonal', 'orthogonal', 61, 884, 876, 'M410.2638445208854,198.6050215544483L410.2802616177371,270.8941757648838', '#000', 'Tahap Koreksi Eselon IV', 0.48416946108235, 1, 0, 6, NULL, '[{\"field\":\"tsk_exam1_flag\",\"comparison\":\"is empty\",\"value\":\"\",\"operator\":\"AND\"},{\"field\":\"tsk_exam2_flag\",\"comparison\":\"is empty\",\"value\":\"\",\"operator\":\"AND\"},{\"field\":\"tsk_exam2_flag\",\"comparison\":\"is empty\",\"value\":\"\",\"operator\":\"\"}]');
INSERT INTO `bpm_links` VALUES (685, 'tahap-koreksi-eselon-iii', 'graph-link-3', 'graph-shape-2', 'graph-shape-3', 'Graph.link.Orthogonal', 'orthogonal', 61, 876, 877, 'M410.2804887209297,330.894175764886L410.28048872091745,404.8941757648847', '#000', 'Tahap Koreksi Eselon III', 0.4983136830565, 1, 0, 6, NULL, '[{\"field\":\"tsk_exam1_flag\",\"comparison\":\"=\",\"value\":\"APPROVED\",\"operator\":\"\"}]');
INSERT INTO `bpm_links` VALUES (686, 'tahap-koreksi-kapus', 'graph-link-4', 'graph-shape-3', 'graph-shape-4', 'Graph.link.Orthogonal', 'orthogonal', 61, 877, 878, 'M410.280547324914,464.89417576488665L410.2854312359101,548.2316722640245', '#000', 'Tahap Koreksi Kapus', 0.4649794500063, 1, 0, 6, NULL, '[{\"field\":\"tsk_exam2_flag\",\"comparison\":\"=\",\"value\":\"APPROVED\",\"operator\":\"\"}]');
INSERT INTO `bpm_links` VALUES (687, 'tahap-paraf-kapus', 'graph-link-5', 'graph-shape-4', 'graph-shape-5', 'Graph.link.Orthogonal', 'orthogonal', 61, 878, 879, 'M410.28553682771167,608.2316722640188L410.2902415028407,708.3571449392942', '#000', 'Tahap Paraf Kapus', 0.49937630062606, 1, 0, 6, NULL, '[{\"field\":\"tsk_exam3_flag\",\"comparison\":\"=\",\"value\":\"APPROVED\",\"operator\":\"\"}]');
INSERT INTO `bpm_links` VALUES (688, 'tahap-cetak', 'graph-link-6', 'graph-shape-5', 'graph-shape-6', 'Graph.link.Orthogonal', 'orthogonal', 61, 879, 880, 'M410.2903413291999,768.3571449392924L410.294938301249,855.3574849337868', '#000', 'Tahap Cetak', 0.5028744958368, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (689, 'tahap-pengiriman', 'graph-link-7', 'graph-shape-6', 'graph-shape-7', 'Graph.link.Orthogonal', 'orthogonal', 61, 880, 881, 'M410.29504766230355,915.3574849337798L410.29989088646244,1001.044122508733', '#000', 'Tahap Pengiriman', 0.50329024130916, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (690, 'tahap-konfirmasi', 'graph-link-8', 'graph-shape-7', 'graph-shape-8', 'Graph.link.Orthogonal', 'orthogonal', 61, 881, 882, 'M410.2999989765792,1061.044122508729L410.304756109953,1153.294537136156', '#000', 'Tahap Konfirmasi', 0.4810304202548, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (692, 'tahap-pembuatan', 'graph-link-9', 'graph-shape-2', 'graph-shape-10', 'Graph.link.Orthogonal', 'orthogonal', 61, 876, 884, 'M340.28048872091847,300.89417576488495L227.2636174177077,300.8941757648846L227.2636174177077,184.6050215544476L340.2636174177054,184.60502155444755', '#000', 'Tahap Pembuatan', 0.5, 1, 0, 6, NULL, '[{\"field\":\"tsk_exam1_flag\",\"comparison\":\"=\",\"value\":\"REVISE\",\"operator\":\"\"}]');
INSERT INTO `bpm_links` VALUES (693, 'tahap-pembuatan', 'graph-link-10', 'graph-shape-3', 'graph-shape-10', 'Graph.link.Orthogonal', 'orthogonal', 61, 877, 884, 'M340.28048872091847,434.8941757648764L195.77198672893329,434.8941757648846L195.77198672893329,168.60502155444757L340.2636174177055,168.60502155444738', '#000', 'Tahap Pembuatan', 0.14519542628132, 1, 0, 6, NULL, '[{\"field\":\"tsk_exam2_flag\",\"comparison\":\"=\",\"value\":\"REVISE\",\"operator\":\"\"}]');
INSERT INTO `bpm_links` VALUES (694, 'tahap-pembuatan', 'graph-link-11', 'graph-shape-4', 'graph-shape-10', 'Graph.link.Orthogonal', 'orthogonal', 61, 878, 884, 'M340.2854898399248,578.2316722640359L155.64794487438613,578.2316722640209L155.64794487438613,154.16743033641293L340.263617417706,154.1674303364123', '#000', 'Tahap Pembuatan', 0.12841717523301, 1, 0, 6, NULL, '[{\"field\":\"tsk_exam3_flag\",\"comparison\":\"=\",\"value\":\"REVISE\",\"operator\":\"\"}]');
INSERT INTO `bpm_links` VALUES (696, 'tahap-registrasi', 'graph-link-1', 'graph-shape-1', 'graph-shape-2', 'Graph.link.Orthogonal', 'orthogonal', 60, 885, 886, 'M386.382797286556,96.21874999999955L386.3827972865561,179.21874999999977', '#000', 'Tahap Registrasi', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (697, 'tahap-kodefikasi', 'graph-link-2', 'graph-shape-2', 'graph-shape-3', 'Graph.link.Orthogonal', 'orthogonal', 60, 886, 887, 'M386.38279728655556,239.2187500000004L386.382797286556,307.2187500000009', '#000', 'Tahap Kodefikasi', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (698, 'tahap-scan', 'graph-link-3', 'graph-shape-3', 'graph-shape-4', 'Graph.link.Orthogonal', 'orthogonal', 60, 887, 888, 'M386.382797286556,367.21875000000006L386.3827972865561,452.21874999999966', '#000', 'Tahap Scan', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (699, 'tahap-surat-dibaca', 'graph-link-4', 'graph-shape-4', 'graph-shape-5', 'Graph.link.Orthogonal', 'orthogonal', 60, 888, 889, 'M386.3827972865561,512.2187499999989L386.3827972865561,600.2187500000005', '#000', 'Tahap Surat Dibaca', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (700, 'tahap-disposisi', 'graph-link-5', 'graph-shape-5', 'graph-shape-6', 'Graph.link.Orthogonal', 'orthogonal', 60, 889, 890, 'M386.38279728654294,660.2187499999981L386.3827972865484,749.2187499999992', '#000', 'Tahap Disposisi', 0.5, 1, 0, 6, NULL, '[{\"field\":\"tsm_flag\",\"comparison\":\"=\",\"value\":\"DISPOSITION\",\"operator\":\"\"}]');
INSERT INTO `bpm_links` VALUES (701, 'tahap-balas-surat', 'graph-link-6', 'graph-shape-6', 'graph-shape-7', 'Graph.link.Orthogonal', 'orthogonal', 60, 890, 891, 'M386.38279728655243,809.2187499999987L386.3827972865491,913.2187500000018', '#000', 'Tahap Balas Surat', 0.5, 1, 0, 6, NULL, '[{\"field\":\"tsm_flag\",\"comparison\":\"=\",\"value\":\"REPLY\",\"operator\":\"\"}]');
INSERT INTO `bpm_links` VALUES (702, 'arsip-surat-masuk', 'graph-link-7', 'graph-shape-7', 'graph-shape-8', 'Graph.link.Orthogonal', 'orthogonal', 60, 891, 892, 'M386.38279728655806,973.2187500000001L386.3827972865636,1082.2187499999977', '#000', 'Arsip Surat Masuk', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (703, NULL, 'graph-link-8', 'graph-shape-8', 'graph-shape-9', 'Graph.link.Orthogonal', 'orthogonal', 60, 892, 893, 'M386.3827972865491,1142.2187500000005L386.38279728655317,1238.2187500000045', '#000', '', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (704, 'tahap-koreksi-eselon-iii', 'graph-link-12', 'graph-shape-10', 'graph-shape-3', 'Graph.link.Orthogonal', 'orthogonal', 61, 884, 877, 'M480.26361741770916,188.6050215544369L593.272053069314,188.60502155444004L593.272053069314,434.89417576488L480.2804887209204,434.8941757648689', '#000', 'Tahap Koreksi Eselon III', 0.5, 1, 0, 6, NULL, '[{\"field\":\"tsk_exam1_flag\",\"comparison\":\"=\",\"value\":\"APPROVED\",\"operator\":\"AND\"},{\"field\":\"tsk_exam3_flag\",\"comparison\":\"is empty\",\"value\":\"\",\"operator\":\"\"}]');
INSERT INTO `bpm_links` VALUES (705, 'tahap-koreksi-kapus', 'graph-link-13', 'graph-shape-10', 'graph-shape-4', 'Graph.link.Orthogonal', 'orthogonal', 61, 884, 878, 'M480.26361741771075,168.60502155443993L762.2745536288136,168.60502155444L762.2745536288136,578.23167226402L480.2854898399215,578.2316722640176', '#000', 'Tahap Koreksi Kapus', 0.88971988636782, 1, 0, 6, NULL, '[{\"field\":\"tsk_exam1_flag\",\"comparison\":\"=\",\"value\":\"APPROVED\",\"operator\":\"AND\"},{\"field\":\"tsk_exam2_flag\",\"comparison\":\"=\",\"value\":\"APPROVED\",\"operator\":\"\"}]');
INSERT INTO `bpm_links` VALUES (707, 'arsip-surat-keluar', 'graph-link-14', 'graph-shape-8', 'graph-shape-11', 'Graph.link.Orthogonal', 'orthogonal', 61, 882, 894, 'M410.3048076775575,1213.2945371360981L410.30480767756364,1299.2187499999989', '#000', 'Arsip Surat Keluar', 0.5, 1, 0, 6, NULL, '[{\"field\":\"tsk_flag\",\"comparison\":\"=\",\"value\":\"DONE\",\"operator\":\"\"}]');
INSERT INTO `bpm_links` VALUES (708, NULL, 'graph-link-15', 'graph-shape-11', 'graph-shape-9', 'Graph.link.Orthogonal', 'orthogonal', 61, 894, 883, 'M410.3048076775599,1359.218750000005L410.30480767758274,1434.0086348716004', '#000', '', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO `bpm_links` VALUES (709, 'tahap-pembuatan', 'graph-link-16', 'graph-shape-8', 'graph-shape-10', 'Graph.link.Orthogonal', 'orthogonal', 61, 882, 884, 'M480.3048076775687,1183.2945371360831L844.3787265417023,1183.2945371361L844.3787265417023,150.5177501380212L480.2636174177091,150.51775013802148', '#000', 'Tahap Pembuatan', 0.047559402924957, 1, 0, 6, NULL, '[{\"field\":\"tsk_flag\",\"comparison\":\"=\",\"value\":\"RECYCLE\",\"operator\":\"\"}]');
INSERT INTO `bpm_links` VALUES (710, 'arsip-surat-masuk', 'graph-link-9', 'graph-shape-5', 'graph-shape-8', 'Graph.link.Orthogonal', 'orthogonal', 60, 889, 892, 'M316.3827972865608,630.2187500000041L142.2562548725226,630.21875L142.2562548725226,1125.3438329254855L316.3827972865628,1125.3438329254868', '#000', 'Arsip Surat Masuk', 0.13635717315543, 1, 0, 6, NULL, '[{\"field\":\"tsm_flag\",\"comparison\":\"=\",\"value\":\"ARCHIVED\",\"operator\":\"\"}]');
INSERT INTO `bpm_links` VALUES (711, 'arsip-surat-masuk', 'graph-link-10', 'graph-shape-6', 'graph-shape-8', 'Graph.link.Orthogonal', 'orthogonal', 60, 890, 892, 'M316.3827972865599,779.2187500000005L194.75658657447718,779.21875L194.75658657447718,1097.7811587819651L316.3827972865605,1097.781158781965', '#000', 'Arsip Surat Masuk', 0.1090223143813, 1, 0, 6, NULL, '[{\"field\":\"tsm_flag\",\"comparison\":\"=\",\"value\":\"ARCHIVED\",\"operator\":\"\"}]');

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
) ENGINE = InnoDB AUTO_INCREMENT = 895 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of bpm_shapes
-- ----------------------------
INSERT INTO `bpm_shapes` VALUES (875, 'graph-shape-1', NULL, NULL, 'Graph.shape.activity.Start', NULL, 61, NULL, 60, 60, 380.26361741771, 5.9417948125039, 0, 'Start', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (876, 'graph-shape-2', NULL, NULL, 'Graph.shape.activity.Action', NULL, 61, NULL, 140, 60, 340.28048872092, 270.89417576488, 0, 'Tahap Koreksi Eselon IV', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (877, 'graph-shape-3', NULL, NULL, 'Graph.shape.activity.Action', NULL, 61, NULL, 140, 60, 340.28048872092, 404.89417576488, 0, 'Tahap Koreksi Eselon III', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (878, 'graph-shape-4', NULL, NULL, 'Graph.shape.activity.Action', NULL, 61, NULL, 140, 60, 340.28548983992, 548.23167226402, 0, 'Tahap Koreksi Kapus', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (879, 'graph-shape-5', NULL, NULL, 'Graph.shape.activity.Action', NULL, 61, NULL, 140, 60, 340.29028849063, 708.35714493929, 0, 'Tahap Paraf Kapus', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (880, 'graph-shape-6', NULL, NULL, 'Graph.shape.activity.Action', NULL, 61, NULL, 140, 60, 340.2949911398, 855.35748493378, 0, 'Tahap Cetak', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (881, 'graph-shape-7', NULL, NULL, 'Graph.shape.activity.Action', NULL, 61, NULL, 140, 60, 340.29994740895, 1001.0441225087, 0, 'Tahap Pengiriman', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (882, 'graph-shape-8', NULL, NULL, 'Graph.shape.activity.Action', NULL, 61, NULL, 140, 60, 340.30480767757, 1153.2945371361, 0, 'Tahap Konfirmasi', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (883, 'graph-shape-9', NULL, NULL, 'Graph.shape.activity.Final', NULL, 61, NULL, 60, 60, 380.30480767757, 1434.0086348716, 0, 'End', '#FF4081', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (884, 'graph-shape-10', NULL, NULL, 'Graph.shape.activity.Action', NULL, 61, NULL, 140, 60, 340.26361741771, 138.60502155444, 0, 'Tahap Pembuatan', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (885, 'graph-shape-1', NULL, NULL, 'Graph.shape.activity.Start', NULL, 60, NULL, 60, 60, 356.38279728656, 36.21875, 0, 'Start', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (886, 'graph-shape-2', NULL, NULL, 'Graph.shape.activity.Action', NULL, 60, NULL, 140, 60, 316.38279728656, 179.21875, 0, 'Tahap Registrasi', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (887, 'graph-shape-3', NULL, NULL, 'Graph.shape.activity.Action', NULL, 60, NULL, 140, 60, 316.38279728656, 307.21875, 0, 'Tahap Kodefikasi', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (888, 'graph-shape-4', NULL, NULL, 'Graph.shape.activity.Action', NULL, 60, NULL, 140, 60, 316.38279728656, 452.21875, 0, 'Tahap Scan', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (889, 'graph-shape-5', NULL, NULL, 'Graph.shape.activity.Action', NULL, 60, NULL, 140, 60, 316.38279728656, 600.21875, 0, 'Tahap Surat Dibaca', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (890, 'graph-shape-6', NULL, NULL, 'Graph.shape.activity.Action', NULL, 60, NULL, 140, 60, 316.38279728656, 749.21875, 0, 'Tahap Disposisi', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (891, 'graph-shape-7', NULL, NULL, 'Graph.shape.activity.Action', NULL, 60, NULL, 140, 60, 316.38279728656, 913.21875, 0, 'Tahap Balas Surat', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (892, 'graph-shape-8', NULL, NULL, 'Graph.shape.activity.Action', NULL, 60, NULL, 140, 60, 316.38279728656, 1082.21875, 0, 'Arsip Surat Masuk', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (893, 'graph-shape-9', NULL, NULL, 'Graph.shape.activity.Final', NULL, 60, NULL, 60, 60, 356.38279728656, 1238.21875, 0, 'End', '#FF4081', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO `bpm_shapes` VALUES (894, 'graph-shape-11', NULL, NULL, 'Graph.shape.activity.Action', NULL, 61, NULL, 140, 60, 340.30480767757, 1299.21875, 0, 'Arsip Surat Keluar', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');

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
  PRIMARY KEY (`kp_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 124 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of kanban_panels
-- ----------------------------
INSERT INTO `kanban_panels` VALUES (79, 22, 'Tahap Registrasi', '#9c27b0', 0);
INSERT INTO `kanban_panels` VALUES (80, 23, 'Tahap Pembuatan', '#9c27b0', 0);
INSERT INTO `kanban_panels` VALUES (81, 23, 'Tahap Koreksi Eselon IV', '#2196f3', 1);
INSERT INTO `kanban_panels` VALUES (82, 23, 'Tahap Koreksi Eselon III', '#ffc107', 2);
INSERT INTO `kanban_panels` VALUES (83, 23, 'Tahap Koreksi Kapus', '#f44336', 3);
INSERT INTO `kanban_panels` VALUES (84, 23, 'Tahap Paraf Kapus', '#607d8b', 4);
INSERT INTO `kanban_panels` VALUES (86, 23, 'Tahap Pengiriman', '#607d8b', 6);
INSERT INTO `kanban_panels` VALUES (87, 23, 'Tahap Konfirmasi', '#e91e63', 7);
INSERT INTO `kanban_panels` VALUES (116, 22, 'Tahap Kodefikasi', '#f44336', 1);
INSERT INTO `kanban_panels` VALUES (117, 22, 'Tahap Scan', '#ffc107', 2);
INSERT INTO `kanban_panels` VALUES (118, 22, 'Tahap Surat Dibaca', '#3f51b5', 3);
INSERT INTO `kanban_panels` VALUES (119, 22, 'Tahap Disposisi', '#e91e63', 4);
INSERT INTO `kanban_panels` VALUES (120, 22, 'Tahap Balas Surat', '#2196f3', 5);
INSERT INTO `kanban_panels` VALUES (121, 22, 'Arsip Surat Masuk', '#009688', 6);
INSERT INTO `kanban_panels` VALUES (122, 23, 'Tahap Cetak', '#3f51b5', 5);
INSERT INTO `kanban_panels` VALUES (123, 23, 'Arsip Surat Keluar', '#9c27b0', 8);

-- ----------------------------
-- Table structure for kanban_settings
-- ----------------------------
DROP TABLE IF EXISTS `kanban_settings`;
CREATE TABLE `kanban_settings`  (
  `ks_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ks_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ks_description` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ks_api` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ks_image` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ks_purpose` int(1) NULL DEFAULT 0,
  PRIMARY KEY (`ks_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of kanban_settings
-- ----------------------------
INSERT INTO `kanban_settings` VALUES (22, 'Template Surat Masuk', 'Template administrasi surat masuk', NULL, NULL, 1);
INSERT INTO `kanban_settings` VALUES (23, 'Template Surat Keluar', 'Template administrasi surat keluar', NULL, NULL, 2);

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
  PRIMARY KEY (`kst_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 146 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of kanban_statuses
-- ----------------------------
INSERT INTO `kanban_statuses` VALUES (85, 79, 60, 696, '#000');
INSERT INTO `kanban_statuses` VALUES (86, 80, 61, 683, '#000');
INSERT INTO `kanban_statuses` VALUES (87, 80, 61, 692, '#000');
INSERT INTO `kanban_statuses` VALUES (88, 80, 61, 693, '#000');
INSERT INTO `kanban_statuses` VALUES (89, 80, 61, 694, '#000');
INSERT INTO `kanban_statuses` VALUES (91, 81, 61, 684, '#000');
INSERT INTO `kanban_statuses` VALUES (92, 82, 61, 685, '#000');
INSERT INTO `kanban_statuses` VALUES (93, 83, 61, 686, '#000');
INSERT INTO `kanban_statuses` VALUES (94, 84, 61, 687, '#000');
INSERT INTO `kanban_statuses` VALUES (96, 86, 61, 689, '#000');
INSERT INTO `kanban_statuses` VALUES (97, 87, 61, 690, '#000');
INSERT INTO `kanban_statuses` VALUES (132, 116, 60, 697, '#000');
INSERT INTO `kanban_statuses` VALUES (133, 117, 60, 698, '#000');
INSERT INTO `kanban_statuses` VALUES (134, 118, 60, 699, '#000');
INSERT INTO `kanban_statuses` VALUES (135, 119, 60, 700, '#000');
INSERT INTO `kanban_statuses` VALUES (136, 120, 60, 701, '#000');
INSERT INTO `kanban_statuses` VALUES (137, 121, 60, 702, '#000');
INSERT INTO `kanban_statuses` VALUES (138, 82, 61, 704, '#000');
INSERT INTO `kanban_statuses` VALUES (139, 83, 61, 705, '#000');
INSERT INTO `kanban_statuses` VALUES (141, 122, 61, 688, '#000');
INSERT INTO `kanban_statuses` VALUES (142, 123, 61, 707, '#000');
INSERT INTO `kanban_statuses` VALUES (143, 80, 61, 709, '#000');
INSERT INTO `kanban_statuses` VALUES (144, 121, 60, 710, '#000');
INSERT INTO `kanban_statuses` VALUES (145, 121, 60, 711, '#000');

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
INSERT INTO `sys_captcha` VALUES ('127.0.0.1', '5c3a38d8-6348-45e4-92a7-2d13527babda', 'fpv', 'fpv', 1522045175, NULL);
INSERT INTO `sys_captcha` VALUES ('127.0.0.1', '9475a570-be3d-4889-b607-939a46f0cb53', 'hdw', 'hdw', 1522045149, NULL);
INSERT INTO `sys_captcha` VALUES ('127.0.0.1', 'a62ad333-450d-4900-8c3f-0f7f395eda2f', 'tra', 'tra', 1522045217, NULL);

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
INSERT INTO `sys_company` VALUES (1, 'Pusdiklat Tenaga Administrasi', 'Jl. Kemerdekaan No. 45, Ciputat, Tangerang Selatan', '(021) 77126162', '(021) 77182717', 'pusdikadm@kemenag.go.id', 'http://pta.kemenag.go.id', 1, '9c0f55e773804793bc2d4f9aa242f878.png');

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
INSERT INTO `sys_config` VALUES (3, 'app_title', 'E-OFFICE');
INSERT INTO `sys_config` VALUES (4, 'app_version', '2.0.5');
INSERT INTO `sys_config` VALUES (5, 'app_description', 'Administrasi surat masuk dan surat keluar');
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
-- Table structure for sys_departments
-- ----------------------------
DROP TABLE IF EXISTS `sys_departments`;
CREATE TABLE `sys_departments`  (
  `sdp_id` int(11) NOT NULL AUTO_INCREMENT,
  `sdp_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sdp_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_departments
-- ----------------------------
INSERT INTO `sys_departments` VALUES (1, 'Badan Litbang dan Diklat Kementerian Agama');

-- ----------------------------
-- Table structure for sys_jobs
-- ----------------------------
DROP TABLE IF EXISTS `sys_jobs`;
CREATE TABLE `sys_jobs`  (
  `sj_id` int(11) NOT NULL AUTO_INCREMENT,
  `sj_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sj_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_jobs
-- ----------------------------
INSERT INTO `sys_jobs` VALUES (1, 'Jabatan Fungsional Umum');

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
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_labels
-- ----------------------------
INSERT INTO `sys_labels` VALUES ('pengawasan', 7, '2017-12-24 13:53:18', '#3f51b5', 11);
INSERT INTO `sys_labels` VALUES ('pelaksanaan', 7, '2017-12-25 04:12:10', '#e91e63', 12);
INSERT INTO `sys_labels` VALUES ('undangan', 7, '2017-12-25 04:12:43', '#9c27b0', 13);
INSERT INTO `sys_labels` VALUES ('test', 7, '2018-01-03 17:08:00', '#2196f3', 14);
INSERT INTO `sys_labels` VALUES ('closed', 7, '2018-01-18 23:01:10', '#009688', 15);
INSERT INTO `sys_labels` VALUES ('prioritas', 2, '2018-01-25 07:42:08', 'var(--paper-red-500)', 16);
INSERT INTO `sys_labels` VALUES ('koreksi', 2, '2018-01-25 08:06:30', 'var(--paper-amber-500)', 17);
INSERT INTO `sys_labels` VALUES ('valid', 2, '2018-01-25 08:06:47', '#4caf50', 18);
INSERT INTO `sys_labels` VALUES ('umum', 1, '2018-02-17 00:13:02', '#607d8b', 19);

-- ----------------------------
-- Table structure for sys_menus
-- ----------------------------
DROP TABLE IF EXISTS `sys_menus`;
CREATE TABLE `sys_menus`  (
  `smn_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `smn_parent_id` bigint(20) NULL DEFAULT NULL,
  `smn_title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `smn_icon` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `smn_path` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `smn_order` bigint(20) NULL DEFAULT NULL,
  `smn_visible` int(11) NULL DEFAULT 1,
  `smn_default` int(11) NULL DEFAULT 0,
  `smn_group` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`smn_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_menus
-- ----------------------------
INSERT INTO `sys_menus` VALUES (1, 0, 'Homepage', 'social:public', '/home', 1, 1, 1, NULL);
INSERT INTO `sys_menus` VALUES (3, 0, 'Surat Masuk', 'drafts', '/suratmasuk', 4, 1, 0, 'Monitoring');
INSERT INTO `sys_menus` VALUES (7, 0, 'Konfigurasi', 'settings', '/settings', 8, 1, 0, 'Aplikasi');
INSERT INTO `sys_menus` VALUES (19, 0, 'Administrasi', 'description', '/worksheet', 3, 1, 0, 'Transaksi');
INSERT INTO `sys_menus` VALUES (20, 0, 'Label Pendanda', 'label-outline', '/references/labels', 6, 1, 0, 'Referensi');
INSERT INTO `sys_menus` VALUES (22, 0, 'Notifikasi', 'social:notifications', '/notifications', 2, 1, 0, NULL);
INSERT INTO `sys_menus` VALUES (23, 0, 'Surat Keluar', 'mail', '/suratkeluar', 5, 1, 0, NULL);
INSERT INTO `sys_menus` VALUES (24, 0, 'Klasifikasi Surat', 'label-outline', '/references/classifications', 7, 1, 0, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_modules
-- ----------------------------
INSERT INTO `sys_modules` VALUES (1, 'assets', '1.0.0', 'Assets', 'Londomloto', 'https://github.com/londomloto/pusdikadm.git', '/assets');
INSERT INTO `sys_modules` VALUES (2, 'auth', '1.0.0', 'Authentication', 'Londomloto', 'https://github.com/londomloto/pusdikadm.git', '/auth');
INSERT INTO `sys_modules` VALUES (3, 'application', '1.0.0', 'Application', 'Londomloto', 'https://github.com/londomloto/pusdikadm.git', '/');
INSERT INTO `sys_modules` VALUES (5, 'home', '1.0.0', 'Homepage', 'Londomloto', 'https://github.com/londomloto/pusdikadm.git', '/home');
INSERT INTO `sys_modules` VALUES (7, 'roles', '1.0.0', 'Roles', 'Londomloto', 'https://github.com/londomloto/pusdikadm.git', '/roles');
INSERT INTO `sys_modules` VALUES (8, 'users', '1.0.0', 'Users', 'Londomloto', 'https://github.com/londomloto/pusdikadm.git', '/users');
INSERT INTO `sys_modules` VALUES (9, 'modules', '1.0.0', 'Modules', 'Londomloto', 'https://github.com/londomloto/pusdikadm.git', '/modules');
INSERT INTO `sys_modules` VALUES (13, 'dashboard', '1.0.0', 'Dashboard', 'Londomloto', 'https://github.com/londomloto/pusdikadm.git', '/dashboard');
INSERT INTO `sys_modules` VALUES (17, 'settings', '1.0.0', 'Settings', 'Londomloto', 'https://github.com/londomloto/pusdikadm.git', '/settings');
INSERT INTO `sys_modules` VALUES (18, 'worksheet', '1.0.0', 'Worksheet', 'Londomloto', 'https://github.com/londomloto/pusdikadm.git', '/worksheet');
INSERT INTO `sys_modules` VALUES (19, 'labels', '1.0.0', 'Labels', 'Londomloto', 'https://github.com/londomloto/pusdikadm.git', '/references/labels');
INSERT INTO `sys_modules` VALUES (20, 'units', '1.0.0', 'Units', 'Londomloto', NULL, '/references/units');
INSERT INTO `sys_modules` VALUES (21, 'notifications', '1.0.0', 'Notifications', 'Londomloto', NULL, '/notifications');
INSERT INTO `sys_modules` VALUES (22, 'statistic', '1.0.0', 'Statistics', 'Londomloto', NULL, '/stat');
INSERT INTO `sys_modules` VALUES (23, 'reports', '1.0.0', 'Reports', 'Londomloto', NULL, '/reports');
INSERT INTO `sys_modules` VALUES (24, 'classifications', '1.0.0', 'Classifications', 'Londomloto', NULL, '/references/classifications');
INSERT INTO `sys_modules` VALUES (25, 'suratmasuk', '1.0.0', 'Surat Masuk', 'KCT Team', NULL, '/suratmasuk');
INSERT INTO `sys_modules` VALUES (26, 'suratkeluar', '1.0.0', 'Surat Keluar', 'KCT Team', NULL, '/suratkeluar');

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
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_modules_capabilities
-- ----------------------------
INSERT INTO `sys_modules_capabilities` VALUES (31, 2, 'login_browser', 'Mengizinkan user login dari browser');
INSERT INTO `sys_modules_capabilities` VALUES (32, 2, 'login_mobile', 'Mengizinkan user login dari perangkat mobile');

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_numbers
-- ----------------------------
INSERT INTO `sys_numbers` VALUES (1, 'SM_SEQUENCE', 46, 5, '', NULL);
INSERT INTO `sys_numbers` VALUES (2, 'SK_SEQUENCE', 58, 5, NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 49 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_projects
-- ----------------------------
INSERT INTO `sys_projects` VALUES (36, 'private', 'private', 'Private', NULL, NULL, NULL, 7, '2018-01-20 02:34:17', 19);
INSERT INTO `sys_projects` VALUES (47, 'private', 'surat-keluar', 'Surat Keluar', 'Administrasi surat keluar', NULL, NULL, 1, '2018-02-05 14:45:09', 23);
INSERT INTO `sys_projects` VALUES (48, 'private', 'surat-masuk', 'Surat Masuk', 'Administrasi surat masuk', NULL, NULL, 1, '2018-02-05 14:48:52', 22);

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
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_projects_users
-- ----------------------------
INSERT INTO `sys_projects_users` VALUES (20, 7, 12);
INSERT INTO `sys_projects_users` VALUES (21, 7, 13);
INSERT INTO `sys_projects_users` VALUES (36, 7, 73);
INSERT INTO `sys_projects_users` VALUES (47, 1, 95);
INSERT INTO `sys_projects_users` VALUES (48, 1, 96);
INSERT INTO `sys_projects_users` VALUES (47, 2, 97);
INSERT INTO `sys_projects_users` VALUES (47, 3, 98);
INSERT INTO `sys_projects_users` VALUES (47, 4, 99);
INSERT INTO `sys_projects_users` VALUES (48, 2, 100);
INSERT INTO `sys_projects_users` VALUES (48, 3, 101);
INSERT INTO `sys_projects_users` VALUES (48, 4, 102);

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
  `srm_selected` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`srm_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 54 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_roles_menus
-- ----------------------------
INSERT INTO `sys_roles_menus` VALUES (1, 4, 1, 1);
INSERT INTO `sys_roles_menus` VALUES (4, 4, 3, 1);
INSERT INTO `sys_roles_menus` VALUES (8, 4, 7, 1);
INSERT INTO `sys_roles_menus` VALUES (9, 4, 19, 1);
INSERT INTO `sys_roles_menus` VALUES (10, 4, 20, 1);
INSERT INTO `sys_roles_menus` VALUES (11, 16, 1, 1);
INSERT INTO `sys_roles_menus` VALUES (12, 16, 3, 1);
INSERT INTO `sys_roles_menus` VALUES (13, 16, 7, 0);
INSERT INTO `sys_roles_menus` VALUES (14, 16, 19, 1);
INSERT INTO `sys_roles_menus` VALUES (15, 16, 20, 1);
INSERT INTO `sys_roles_menus` VALUES (17, 7, 19, 1);
INSERT INTO `sys_roles_menus` VALUES (18, 7, 1, 1);
INSERT INTO `sys_roles_menus` VALUES (19, 17, 1, 1);
INSERT INTO `sys_roles_menus` VALUES (20, 17, 3, 1);
INSERT INTO `sys_roles_menus` VALUES (21, 17, 19, 1);
INSERT INTO `sys_roles_menus` VALUES (22, 18, 1, 1);
INSERT INTO `sys_roles_menus` VALUES (23, 18, 3, 1);
INSERT INTO `sys_roles_menus` VALUES (24, 18, 7, 0);
INSERT INTO `sys_roles_menus` VALUES (25, 18, 19, 1);
INSERT INTO `sys_roles_menus` VALUES (26, 18, 20, 1);
INSERT INTO `sys_roles_menus` VALUES (27, 7, 3, 1);
INSERT INTO `sys_roles_menus` VALUES (28, 7, 20, 1);
INSERT INTO `sys_roles_menus` VALUES (29, 17, 7, 1);
INSERT INTO `sys_roles_menus` VALUES (30, 17, 20, 1);
INSERT INTO `sys_roles_menus` VALUES (31, 19, 1, 1);
INSERT INTO `sys_roles_menus` VALUES (32, 19, 3, 1);
INSERT INTO `sys_roles_menus` VALUES (33, 19, 19, 1);
INSERT INTO `sys_roles_menus` VALUES (34, 19, 20, 1);
INSERT INTO `sys_roles_menus` VALUES (35, 20, 1, 1);
INSERT INTO `sys_roles_menus` VALUES (36, 20, 3, 1);
INSERT INTO `sys_roles_menus` VALUES (37, 20, 7, 1);
INSERT INTO `sys_roles_menus` VALUES (38, 20, 19, 1);
INSERT INTO `sys_roles_menus` VALUES (39, 20, 20, 1);
INSERT INTO `sys_roles_menus` VALUES (41, 4, 22, 1);
INSERT INTO `sys_roles_menus` VALUES (42, 4, 23, 1);
INSERT INTO `sys_roles_menus` VALUES (43, 4, 24, 1);
INSERT INTO `sys_roles_menus` VALUES (44, 4, NULL, 0);
INSERT INTO `sys_roles_menus` VALUES (45, 4, NULL, 0);
INSERT INTO `sys_roles_menus` VALUES (46, 4, NULL, 0);
INSERT INTO `sys_roles_menus` VALUES (47, 4, NULL, 1);
INSERT INTO `sys_roles_menus` VALUES (48, 4, NULL, 1);
INSERT INTO `sys_roles_menus` VALUES (49, 4, NULL, 1);
INSERT INTO `sys_roles_menus` VALUES (50, 4, NULL, 1);
INSERT INTO `sys_roles_menus` VALUES (51, 4, NULL, 1);
INSERT INTO `sys_roles_menus` VALUES (52, 4, NULL, 1);
INSERT INTO `sys_roles_menus` VALUES (53, 4, NULL, 1);

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
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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

-- ----------------------------
-- Table structure for sys_roles_statuses
-- ----------------------------
DROP TABLE IF EXISTS `sys_roles_statuses`;
CREATE TABLE `sys_roles_statuses`  (
  `srs_id` int(11) NOT NULL AUTO_INCREMENT,
  `srs_sp_id` int(11) NULL DEFAULT NULL,
  `srs_sr_id` int(11) NULL DEFAULT NULL,
  `srs_kp_id` int(11) NULL DEFAULT NULL,
  `srs_kst_id` int(11) NULL DEFAULT NULL,
  `srs_checked` int(1) NULL DEFAULT 0,
  PRIMARY KEY (`srs_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_roles_statuses
-- ----------------------------
INSERT INTO `sys_roles_statuses` VALUES (11, 37, 7, 80, 86, 0);
INSERT INTO `sys_roles_statuses` VALUES (12, 37, 7, 80, 87, 0);
INSERT INTO `sys_roles_statuses` VALUES (13, 37, 7, 80, 88, 0);
INSERT INTO `sys_roles_statuses` VALUES (14, 37, 7, 80, 89, 0);
INSERT INTO `sys_roles_statuses` VALUES (15, 37, 7, 80, 90, 0);
INSERT INTO `sys_roles_statuses` VALUES (16, 37, 7, 82, 92, 0);
INSERT INTO `sys_roles_statuses` VALUES (17, 37, 7, 83, 93, 0);
INSERT INTO `sys_roles_statuses` VALUES (18, 37, 7, 84, 94, 0);
INSERT INTO `sys_roles_statuses` VALUES (19, 37, 7, 85, 95, 0);
INSERT INTO `sys_roles_statuses` VALUES (20, 37, 7, 86, 96, 0);
INSERT INTO `sys_roles_statuses` VALUES (21, 37, 7, 87, 97, 0);
INSERT INTO `sys_roles_statuses` VALUES (22, 37, 16, 80, 86, 0);
INSERT INTO `sys_roles_statuses` VALUES (23, 37, 16, 80, 87, 0);
INSERT INTO `sys_roles_statuses` VALUES (24, 37, 16, 80, 88, 0);
INSERT INTO `sys_roles_statuses` VALUES (25, 37, 16, 80, 89, 0);
INSERT INTO `sys_roles_statuses` VALUES (26, 37, 16, 80, 90, 0);
INSERT INTO `sys_roles_statuses` VALUES (27, 37, 16, 81, 91, 0);
INSERT INTO `sys_roles_statuses` VALUES (28, 37, 16, 83, 93, 0);
INSERT INTO `sys_roles_statuses` VALUES (29, 37, 16, 84, 94, 0);
INSERT INTO `sys_roles_statuses` VALUES (30, 37, 16, 85, 95, 0);
INSERT INTO `sys_roles_statuses` VALUES (31, 37, 16, 86, 96, 0);
INSERT INTO `sys_roles_statuses` VALUES (32, 37, 16, 87, 97, 0);
INSERT INTO `sys_roles_statuses` VALUES (33, 37, 17, 80, 86, 0);
INSERT INTO `sys_roles_statuses` VALUES (34, 37, 17, 80, 87, 0);
INSERT INTO `sys_roles_statuses` VALUES (35, 37, 17, 80, 88, 0);
INSERT INTO `sys_roles_statuses` VALUES (36, 37, 17, 80, 89, 0);
INSERT INTO `sys_roles_statuses` VALUES (37, 37, 17, 80, 90, 0);
INSERT INTO `sys_roles_statuses` VALUES (38, 37, 17, 85, 95, 0);
INSERT INTO `sys_roles_statuses` VALUES (39, 37, 18, 81, 91, 0);
INSERT INTO `sys_roles_statuses` VALUES (40, 37, 18, 82, 92, 0);
INSERT INTO `sys_roles_statuses` VALUES (41, 37, 18, 83, 93, 0);
INSERT INTO `sys_roles_statuses` VALUES (42, 37, 18, 84, 94, 0);

-- ----------------------------
-- Table structure for sys_units
-- ----------------------------
DROP TABLE IF EXISTS `sys_units`;
CREATE TABLE `sys_units`  (
  `sun_id` int(11) NOT NULL AUTO_INCREMENT,
  `sun_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sun_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_units
-- ----------------------------
INSERT INTO `sys_units` VALUES (2, 'dokumen');
INSERT INTO `sys_units` VALUES (3, 'kegiatan');
INSERT INTO `sys_units` VALUES (4, 'naskah');
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
  `su_access_token` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `su_refresh_token` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `su_sex` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `su_pob` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `su_dob` date NULL DEFAULT NULL,
  `su_scp_id` int(11) NULL DEFAULT NULL,
  `su_sdp_id` int(11) NULL DEFAULT NULL,
  `su_grade` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `su_sj_id` int(11) NULL DEFAULT NULL,
  `su_active` int(11) NULL DEFAULT 0,
  `su_created_date` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP,
  `su_created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'system',
  `su_invite_token` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `su_recover_token` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `su_validation` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `su_ticket` int(11) NULL DEFAULT NULL,
  `su_feed` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`su_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_users
-- ----------------------------
INSERT INTO `sys_users` VALUES (1, '197109012005012005', 4, 'admin@pusdikadm.xyz', '$2y$08$T2h2cWZaU0lIWUpoMFBKSuwWvsjYotQZm5i7AJntaEAOZ2cymi/iu', 'Administrator', 'default-avatar-ginger-guy.png', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MjIwNDUyNDAsImp0aSI6IjBHQXAxWlhmR2lDc21PdkpQbTloanNhVThORTQycTRyeVpPMHdDa2hBY1E9IiwiaXNzIjoiUFVTRElLQURNIiwibmJmIjoxNTIyMDQ1MjQxLCJleHAiOjE1MjIxMjkyNDEsImRhdGEiOnsic3VfZW1haWwiOiJhZG1pbkBwdXNkaWthZG0ueHl6Iiwic3Vfc3JfaWQiOiI0In19.SekLWvf_vGVm56fP_C7x_qpIrQXYjBu7hKzgXdbQtyx9o1nsIamEHxNoCM8m41LB795ki6zme0xHIWzFM-uyPg', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MTkwNTU3NjMsImp0aSI6IjhoZGJPQjhXQXpNNUQwR3Q4VFwveU5jQjc0NGc4VURSZ1ZuSFFrcnphN3hrPSIsImlzcyI6IlBVU0RJS0FETSIsIm5iZiI6MTUxOTA1NTc2NCwiZXhwIjoxNTE5MTYzNzY0LCJkYXRhIjpudWxsfQ.wGwderwFOi_34EyWy4OoKREwgdK3GgTXHpb9XKmWaHD_1IvK6vek6HSuwxILb7-nfXh8_e585fDTx9QfiUTzWA', 'Laki-laki', 'Banyumas', '1985-07-03', 1, 1, 'Penata, III/C', 1, 1, '2017-04-27 20:52:36', 'system', NULL, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MTU2MjQ1NjgsImp0aSI6ImlJbE1VOXdaUGpmd2ZUbk9hMkdUK0oyQlVNTDZCa09oSkx1VFpJa2pCZVU9IiwiaXNzIjoiS3JlYXNpbmRvIENpcHRhIFRla25vbG9naSIsIm5iZiI6MTUxNTYyNDU2OSwiZXhwIjoxNTE1NzA4NTY5LCJkYXRhIjp7InN1X2VtYWlsIjoicm9zb0BrY3QuY28uaWQifX0.o1iI7ZWpATPgALV2P6Frdv09XcMnuIAWd6lImKyZqQN6Y5xp-_JhHC1nxDppVMEUs9qIBOFc8KNHHpBiYM-KZw', NULL, NULL, '[\"9:1\",\"8:1\",\"7:1\",\"5:1\",\"6:1\",\"4:1\"]');
INSERT INTO `sys_users` VALUES (2, NULL, 7, 'eselon4@pusdikadm.xyz', '$2y$08$UWRzU3lrK0NFekprSWdpVelnCWtgEvCMORxnS3kSjUEGzBxxBx1lK', 'User Eselon IV', 'default-avatar-male_12.png', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MTg0NjY5NDEsImp0aSI6IjRWV21yMTk2TW15eE9IcmpGZnRcL2ZDYVFCdGFPN0EwWjFMWUNDOHMzcW9ZPSIsImlzcyI6IlBVU0RJS0FETSIsIm5iZiI6MTUxODQ2Njk0MiwiZXhwIjoxNTE4NTUwOTQyLCJkYXRhIjp7InN1X2VtYWlsIjoiZXNlbG9uNEBwdXNkaWthZG0ueHl6Iiwic3Vfc3JfaWQiOiI3In19.5R7H-e4SHkK_OoLGp7BJdAQIJZ63MNQVECtSGoOKC6M2cez_K1KuJinwBNRAxqncMcfzBtMddrsHJa0CzGNUcQ', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MTg0NjY5NDEsImp0aSI6IkJzVmdxcTZDRDlWQTcxMzFGOXVxRjV0a1lwMHIrRllYSGdlUG9FSVRld3c9IiwiaXNzIjoiUFVTRElLQURNIiwibmJmIjoxNTE4NDY2OTQyLCJleHAiOjE1MTg1NzQ5NDIsImRhdGEiOm51bGx9.nIt_mlL5jE5SZDDyD9_BI71s5x1d0grsfytY0GAzOW2QECCzEL7GsM9bRcngu8COxJnijkWCiMjSk5UcAuHRtg', 'Female', 'Cilacap', NULL, 1, 1, NULL, 1, 1, '2017-05-04 05:55:15', 'system', NULL, NULL, NULL, NULL, '[\"12:1\",\"11:2\",\"10:1\",\"9:1\",\"8:1\",\"7:1\"]');
INSERT INTO `sys_users` VALUES (3, NULL, 16, 'eselon3@pusdikadm.xyz', '$2y$08$NkpiM3VlR3JlNFZqU2hsceEVsA410evwpUesAl.GKYGKxfehDXEWW', 'User Eselon III', 'defaults/avatar-0.jpg', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MTM4MDIxMzcsImp0aSI6Ilp6dXR6SktJaUR3NGNYM0JcL0dcL1dXS280XC9Qb001bmhNd3dPUlNQK1lCcFk9IiwiaXNzIjoiS3JlYXNpbmRvIENpcHRhIFRla25vbG9naSIsIm5iZiI6MTUxMzgwMjEzOCwiZXhwIjoxNTEzODg2MTM4LCJkYXRhIjp7InN1X2VtYWlsIjoiY2FoeWFAa2N0LmNvLmlkIiwic3Vfc3JfaWQiOjR9fQ._ARstWVDFeJw2EGcYYa-ALxPMvC_Kt0AoYBY9l2rI09W1nYaVsVW6z014JvO_iL5iGpv62OjbDWb_ZoT0ps4hw', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MTM4MDIxMzcsImp0aSI6InlMNXBqQWFNTXgwNW45SVdoWDB0NHh4Tkx1aXJFVmh4XC9CN0FIN3JcL2w3Yz0iLCJpc3MiOiJLcmVhc2luZG8gQ2lwdGEgVGVrbm9sb2dpIiwibmJmIjoxNTEzODAyMTM4LCJleHAiOjE1MTM5MTAxMzgsImRhdGEiOm51bGx9.OWVzLds1_aPnMyEOaWWKC4mpiFZGlD5j4ZcA9YwyASj9w8yzOVFq2m02Jnh_JdLgOIaKWy_yCk-C80-3SfGrBg', 'Malex', NULL, NULL, NULL, NULL, NULL, NULL, 1, '2017-05-04 06:24:39', 'system', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_users` VALUES (4, NULL, 17, 'kapus@pusdikadm.xyz', '$2y$08$R25qRXFZQUlZYXBKR0JpeOqrd5lLB0WKsdZBzvv.1dfe9qmXm9OdK', 'User Kapus', 'defaults/avatar-0.jpg', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE0OTM4ODMzMjEsImp0aSI6IlhYaERLUTBSUmtweVBKVEJYbkJNQ3ZaZzU1UnRBWXpiVUVFQkFldEZRZVU9IiwiaXNzIjoiS3JlYXNpbmRvIENpcHRhIFRla25vbG9naSIsIm5iZiI6MTQ5Mzg4MzMyMiwiZXhwIjoxNDkzOTY3MzIyLCJkYXRhIjp7InN1X2VtYWlsIjoiam9obk', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE0OTM4ODMzMjEsImp0aSI6IktjdFwvRG5pWWZVUlRPY2lTZ1VJVEEwNHFIXC91dlJvYW9cL05vcVJaUmNUanc9IiwiaXNzIjoiS3JlYXNpbmRvIENpcHRhIFRla25vbG9naSIsIm5iZiI6MTQ5Mzg4MzMyMiwiZXhwIjoxNDkzOTkxMzIyLCJkYXRhIjpudWxsfQ.rQO76C44g9N', 'Female', NULL, NULL, NULL, NULL, NULL, NULL, 1, '2017-05-04 07:20:15', 'system', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_users` VALUES (16, NULL, 20, 'operator@pusdikadm.xyz', '$2y$08$Y0hZVHJCR2xjWlpHZHlnMuyL5k7KZHUSyvXZV9mzcGjpReuqbkW1S', 'Operator', 'Miniclip-8-Ball-Pool-Avatar-15-180x180.png', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MTcxNzI2NDYsImp0aSI6Inc2TmZQa0pFWVFCXC9JajlhNXJ4RkRcL3E2Z3hkcllkdzUyUGlFSlFEcFIwVT0iLCJpc3MiOiJQVVNESUtBRE0iLCJuYmYiOjE1MTcxNzI2NDcsImV4cCI6MTUxNzI1NjY0NywiZGF0YSI6eyJzdV9lbWFpbCI6Im9wZXJhdG9yQHB1c2Rpa2FkbS54eXoiLCJzdV9zcl9pZCI6IjIwIn19.lk7S0ZkeK4kuPJuCiDK1fK3UpBRzvNMnwxs1FhjQe7yqLBLFImTUW_3kiR9CPM-kglP6rNDict_GpCvMe0qEvw', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MTcxNzI2NDYsImp0aSI6IkROV0xDNnhuRUVJNkliRDVcLzBvSVYyaitpOHk5ZFJSQ25lTlVWc1c5TkVFPSIsImlzcyI6IlBVU0RJS0FETSIsIm5iZiI6MTUxNzE3MjY0NywiZXhwIjoxNTE3MjgwNjQ3LCJkYXRhIjpudWxsfQ.KEwYfeBHjiSAf1WCH4qnTS8yUiLyic0wf5xy2r6UrKAYspH-M13Oit2hhhEQflLpj4VpzgdSDH3HyKCau3-8Ng', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2017-12-29 04:28:21', 'system', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MTQ0OTY1MDEsImp0aSI6IktTeVpnckMrRnpxXC9veE1CblpVNE9LbU02VlJZMEJQblpHMGZOeUVqVDY4PSIsImlzcyI6IktyZWFzaW5kbyBDaXB0YSBUZWtub2xvZ2kiLCJuYmYiOjE1MTQ0OTY1MDIsImV4cCI6MTUxNDU4MDUwMiwiZGF0YSI6eyJzdV9lbWFpbCI6Im51cmZhcmlkODkyNEBnbWFpbC5jb20ifX0.nMDmk6apzl5ukFF2gdXQbnXfa8i3rB3r5YmmfI3A4V28RwRypbrYIczaI8eO1ZqWQsZOrnhPyvqYBkH7ZxP99w', NULL, NULL, NULL, NULL);

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
-- Table structure for sys_users_statuses
-- ----------------------------
DROP TABLE IF EXISTS `sys_users_statuses`;
CREATE TABLE `sys_users_statuses`  (
  `sus_id` int(11) NOT NULL AUTO_INCREMENT,
  `sus_sp_id` int(11) NULL DEFAULT NULL,
  `sus_su_id` int(11) NULL DEFAULT NULL,
  `sus_kp_id` int(11) NULL DEFAULT NULL,
  `sus_kst_id` int(11) NULL DEFAULT NULL,
  `sus_checked` int(1) NULL DEFAULT 0,
  PRIMARY KEY (`sus_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_users_statuses
-- ----------------------------
INSERT INTO `sys_users_statuses` VALUES (31, 37, 1, 80, 86, 1);
INSERT INTO `sys_users_statuses` VALUES (32, 37, 1, 80, 87, 1);
INSERT INTO `sys_users_statuses` VALUES (33, 37, 1, 80, 88, 0);
INSERT INTO `sys_users_statuses` VALUES (34, 37, 1, 80, 89, 0);
INSERT INTO `sys_users_statuses` VALUES (35, 37, 1, 80, 90, 0);
INSERT INTO `sys_users_statuses` VALUES (36, 37, 1, 81, 91, 1);
INSERT INTO `sys_users_statuses` VALUES (37, 37, 1, 82, 92, 0);
INSERT INTO `sys_users_statuses` VALUES (38, 37, 1, 83, 93, 0);
INSERT INTO `sys_users_statuses` VALUES (39, 37, 1, 84, 94, 0);
INSERT INTO `sys_users_statuses` VALUES (40, 37, 1, 85, 95, 0);
INSERT INTO `sys_users_statuses` VALUES (41, 37, 1, 86, 96, 0);
INSERT INTO `sys_users_statuses` VALUES (42, 37, 1, 87, 97, 0);

-- ----------------------------
-- Table structure for trx_classifications
-- ----------------------------
DROP TABLE IF EXISTS `trx_classifications`;
CREATE TABLE `trx_classifications`  (
  `tcs_id` int(11) NOT NULL AUTO_INCREMENT,
  `tcs_code` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tcs_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tcs_desc` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tcs_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_classifications
-- ----------------------------
INSERT INTO `trx_classifications` VALUES (1, '000', 'UMUM', NULL);
INSERT INTO `trx_classifications` VALUES (2, '010', 'Urusan Dalam', NULL);
INSERT INTO `trx_classifications` VALUES (3, '030', 'Kekayaan Daerah', NULL);
INSERT INTO `trx_classifications` VALUES (4, '040', 'Perpustakaan / Dokumen / Kearsipan / Sandi', NULL);
INSERT INTO `trx_classifications` VALUES (5, '050', 'Perencanaan', NULL);
INSERT INTO `trx_classifications` VALUES (6, '060', 'Organisasi / Ketatalaksanaan', NULL);
INSERT INTO `trx_classifications` VALUES (7, '070', 'Penelitian', NULL);
INSERT INTO `trx_classifications` VALUES (8, '080', 'Konperensi', NULL);
INSERT INTO `trx_classifications` VALUES (9, '090', 'Perjalanan Dinas', NULL);
INSERT INTO `trx_classifications` VALUES (10, '100', 'PEMERINTAHAN', NULL);
INSERT INTO `trx_classifications` VALUES (11, '110', 'Pemerintahan Pusat', NULL);
INSERT INTO `trx_classifications` VALUES (12, '120', 'Pemda TK. I', NULL);
INSERT INTO `trx_classifications` VALUES (13, '130', 'Pemda TK. II', NULL);
INSERT INTO `trx_classifications` VALUES (14, '140', 'Pemerintahan Desa', NULL);
INSERT INTO `trx_classifications` VALUES (15, '150', 'DPR - MPR', NULL);
INSERT INTO `trx_classifications` VALUES (16, '160', 'DPRD TK. I', NULL);
INSERT INTO `trx_classifications` VALUES (17, '170', 'DPRD TK. II', NULL);
INSERT INTO `trx_classifications` VALUES (18, '180', 'Hukum', NULL);
INSERT INTO `trx_classifications` VALUES (19, '190', 'Hubungan Luar Negeri', NULL);
INSERT INTO `trx_classifications` VALUES (20, '200', 'POLITIK', NULL);
INSERT INTO `trx_classifications` VALUES (21, '210', 'Kepartaian', NULL);
INSERT INTO `trx_classifications` VALUES (22, '220', 'Organisasi Kemasyarakatan', NULL);
INSERT INTO `trx_classifications` VALUES (23, '230', 'Organisasi Profesi dan Fungsional', NULL);
INSERT INTO `trx_classifications` VALUES (24, '240', 'Organisasi Pemuda', NULL);
INSERT INTO `trx_classifications` VALUES (25, '250', 'Organisasi Buruh, Tani dan Nelayan', NULL);
INSERT INTO `trx_classifications` VALUES (26, '260', 'Organisasi Wanita', NULL);
INSERT INTO `trx_classifications` VALUES (27, '270', 'Pemilihan Umum', NULL);

-- ----------------------------
-- Table structure for trx_flags
-- ----------------------------
DROP TABLE IF EXISTS `trx_flags`;
CREATE TABLE `trx_flags`  (
  `tfg_id` int(11) NOT NULL AUTO_INCREMENT,
  `tfg_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tfg_desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tfg_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_flags
-- ----------------------------
INSERT INTO `trx_flags` VALUES (1, 'DOING', 'Sedang dalam pemeriksaan');
INSERT INTO `trx_flags` VALUES (2, 'APPROVED', 'Dokumen disetujui');
INSERT INTO `trx_flags` VALUES (3, 'REVISE', 'Dokumen perlu diperbaiki');

-- ----------------------------
-- Table structure for trx_receiver
-- ----------------------------
DROP TABLE IF EXISTS `trx_receiver`;
CREATE TABLE `trx_receiver`  (
  `trc_id` int(11) NOT NULL AUTO_INCREMENT,
  `trc_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `trc_group` int(1) NULL DEFAULT 2,
  PRIMARY KEY (`trc_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_receiver
-- ----------------------------
INSERT INTO `trx_receiver` VALUES (1, 'Kepala Pusdiklat Tenaga Administrasi', 1);
INSERT INTO `trx_receiver` VALUES (2, 'Kementerian Dalam Negeri Republik Indonesia', 2);

-- ----------------------------
-- Table structure for trx_sender
-- ----------------------------
DROP TABLE IF EXISTS `trx_sender`;
CREATE TABLE `trx_sender`  (
  `tsn_id` int(11) NOT NULL AUTO_INCREMENT,
  `tsn_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tsn_group` int(1) NULL DEFAULT 1,
  PRIMARY KEY (`tsn_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_sender
-- ----------------------------
INSERT INTO `trx_sender` VALUES (1, 'Kementerian Dalam Negeri', 1);
INSERT INTO `trx_sender` VALUES (2, 'Kepala Pusdiklat Tenaga Administrasi', 2);

-- ----------------------------
-- Table structure for trx_surat_keluar
-- ----------------------------
DROP TABLE IF EXISTS `trx_surat_keluar`;
CREATE TABLE `trx_surat_keluar`  (
  `tsk_id` int(11) NOT NULL AUTO_INCREMENT,
  `tsk_no` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tsk_date` date NULL DEFAULT NULL,
  `tsk_create_date` date NULL DEFAULT NULL,
  `tsk_create_user` int(11) NULL DEFAULT NULL,
  `tsk_tcs_id` int(11) NULL DEFAULT NULL,
  `tsk_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tsk_seq` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tsk_from` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tsk_to` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tsk_subject` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tsk_summary` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `tsk_exam1_user` int(11) NULL DEFAULT NULL,
  `tsk_exam1_date` date NULL DEFAULT NULL,
  `tsk_exam1_note` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tsk_exam1_flag` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tsk_exam2_user` int(11) NULL DEFAULT NULL,
  `tsk_exam2_date` date NULL DEFAULT NULL,
  `tsk_exam2_note` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tsk_exam2_flag` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tsk_exam3_user` int(11) NULL DEFAULT NULL,
  `tsk_exam3_date` date NULL DEFAULT NULL,
  `tsk_exam3_note` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tsk_exam3_flag` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tsk_sign_user` int(11) NULL DEFAULT NULL,
  `tsk_sign_date` date NULL DEFAULT NULL,
  `tsk_send_date` date NULL DEFAULT NULL,
  `tsk_send_note` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tsk_flag` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tsk_admin` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tsk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_surat_keluar
-- ----------------------------
INSERT INTO `trx_surat_keluar` VALUES (1, '00056 / SK / 040 / 212 / 2018', '2018-02-17', '2018-02-17', 1, 1, '-', '00056', 'Kepala Pusdiklat Tenaga Administrasi', 'Kementerian Dalam Negeri Republik Indonesia', 'Undangan', 'Undangan', 1, '2018-02-17', '', 'APPROVED', 1, '2018-02-17', '', 'APPROVED', 1, '2018-02-17', '', 'APPROVED', 1, '2018-02-17', '2018-02-17', NULL, 'DONE', NULL);
INSERT INTO `trx_surat_keluar` VALUES (2, '00058/040-PDM/II/2018', '2018-02-19', '2018-02-19', 1, 4, '-', '00058', 'Kepala Pusdiklat Tenaga Administrasi', 'Kementerian Dalam Negeri Republik Indonesia', 'Undangan Rapat', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 1, '2018-02-19', 'OKE', 'APPROVED', 1, '2018-02-19', 'OKE', 'APPROVED', 1, '2018-02-19', 'OKE', 'APPROVED', 1, '2018-02-19', '2018-02-19', 'Dikirim dengan JNE', 'DONE', 'Bagian Umum');

-- ----------------------------
-- Table structure for trx_surat_keluar_docs
-- ----------------------------
DROP TABLE IF EXISTS `trx_surat_keluar_docs`;
CREATE TABLE `trx_surat_keluar_docs`  (
  `tskd_id` int(11) NOT NULL AUTO_INCREMENT,
  `tskd_tsk_id` int(11) NULL DEFAULT NULL,
  `tskd_orig` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tskd_file` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tskd_mime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tskd_size` double(15, 2) NULL DEFAULT 0.00,
  PRIMARY KEY (`tskd_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_surat_keluar_docs
-- ----------------------------
INSERT INTO `trx_surat_keluar_docs` VALUES (1, 1, 'mar299RFI_187245007.jpg', 'e2d47da458a548a6b39ffd991cc6a8d1.jpg', 'image/jpeg', 351140.00);
INSERT INTO `trx_surat_keluar_docs` VALUES (2, 2, 'marley1209c.jpg', 'ed306a7a6fea4bac98d84b1447e8ffdc.jpg', 'image/jpeg', 316055.00);
INSERT INTO `trx_surat_keluar_docs` VALUES (3, 2, 'marley1209k.jpg', '791a10ab282947d587afc3fee759271c.jpg', 'image/jpeg', 274081.00);

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
  PRIMARY KEY (`tsm_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_surat_masuk
-- ----------------------------
INSERT INTO `trx_surat_masuk` VALUES (1, '00040', '2018-02-17', 1, '00040 / 040 / 212 / 2018', 4, '15678 / A - 040 / 314 / 2018', '2018-02-17', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod\r\ntempor incididunt ut labore et dolore magna aliqua.', NULL, 'Kementerian Dalam Negeri', 'Kepala Pusdiklat Tenaga Administrasi', 'Bagian Umum', 'ARCHIVED', NULL);
INSERT INTO `trx_surat_masuk` VALUES (2, '00041', '2018-02-17', 1, '00041 / A - 040 / 212 / 2018', 4, '15627 / A - 040 / 314 / 2018', '2018-02-17', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod\r\ntempor incididunt ut labore et dolore magna aliqua.', NULL, 'Kementerian Dalam Negeri', 'Kepala Pusdiklat Tenaga Administrasi', 'Bagian Umum', 'REPLY', NULL);
INSERT INTO `trx_surat_masuk` VALUES (3, '00044', '2018-02-17', 1, '15620 / A - 040 / 314 / 2018', 2, '15620 / A - 040 / 314 / 2018', '2018-02-17', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod\r\ntempor incididunt ut labore et dolore magna aliqua.', NULL, 'Kementerian Dalam Negeri', 'Kepala Pusdiklat Tenaga Administrasi', 'Bagian Umum', 'REPLY', NULL);
INSERT INTO `trx_surat_masuk` VALUES (4, '00045', '2018-02-17', 1, 'A', 1, 'A', '2018-02-17', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod\r\ntempor incididunt ut labore et dolore magna aliqua.', NULL, 'Kementerian Dalam Negeri', 'Kepala Pusdiklat Tenaga Administrasi', 'Bagian Umum', 'ARCHIVED', NULL);
INSERT INTO `trx_surat_masuk` VALUES (5, NULL, '2018-02-18', 1, NULL, 6, 'ABC', '2018-02-17', 'Pengawasan', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'Kementerian Dalam Negeri', 'Kepala Pusdiklat Tenaga Administrasi', 'Bagian Umum', NULL, NULL);
INSERT INTO `trx_surat_masuk` VALUES (6, '00046', '2018-02-18', 1, '00046/040-PDM/II/2018', 4, '002/800-SMKN.5/VII/2017', '2018-02-18', 'Undangan', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'Kementerian Dalam Negeri', 'Kepala Pusdiklat Tenaga Administrasi', 'Bagian Umum', 'ARCHIVED', 1);

-- ----------------------------
-- Table structure for trx_surat_masuk_disp
-- ----------------------------
DROP TABLE IF EXISTS `trx_surat_masuk_disp`;
CREATE TABLE `trx_surat_masuk_disp`  (
  `tsmf_id` int(11) NOT NULL AUTO_INCREMENT,
  `tsmf_tsm_id` int(11) NULL DEFAULT NULL,
  `tsmf_date` date NULL DEFAULT NULL,
  `tsmf_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `tsmf_flag` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'DRAFT',
  PRIMARY KEY (`tsmf_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_surat_masuk_disp
-- ----------------------------
INSERT INTO `trx_surat_masuk_disp` VALUES (7, 3, '2018-02-17', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod\r\ntempor incididunt ut labore et dolore magna aliqua.', 'PENDING');
INSERT INTO `trx_surat_masuk_disp` VALUES (8, 2, '2018-02-17', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod\r\ntempor incididunt ut labore et dolore magna aliqua.', 'PENDING');
INSERT INTO `trx_surat_masuk_disp` VALUES (9, 4, '2018-02-17', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod\r\ntempor incididunt ut labore et dolore magna aliqua.', 'DRAFT');
INSERT INTO `trx_surat_masuk_disp` VALUES (10, 4, '2018-02-17', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod\r\ntempor incididunt ut labore et dolore magna aliqua.', 'DRAFT');
INSERT INTO `trx_surat_masuk_disp` VALUES (11, 4, '2018-02-17', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod\r\ntempor incididunt ut labore et dolore magna aliqua.', 'DRAFT');
INSERT INTO `trx_surat_masuk_disp` VALUES (12, 6, '2018-02-18', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'DRAFT');

-- ----------------------------
-- Table structure for trx_surat_masuk_disp_users
-- ----------------------------
DROP TABLE IF EXISTS `trx_surat_masuk_disp_users`;
CREATE TABLE `trx_surat_masuk_disp_users`  (
  `tsmfu_id` int(11) NOT NULL AUTO_INCREMENT,
  `tsmfu_tsmf_id` int(11) NULL DEFAULT NULL,
  `tsmfu_su_id` int(11) NULL DEFAULT NULL,
  `tsmfu_confirm` int(1) NULL DEFAULT 0,
  PRIMARY KEY (`tsmfu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_surat_masuk_disp_users
-- ----------------------------
INSERT INTO `trx_surat_masuk_disp_users` VALUES (7, 7, 1, 0);
INSERT INTO `trx_surat_masuk_disp_users` VALUES (8, 8, 2, 0);
INSERT INTO `trx_surat_masuk_disp_users` VALUES (9, 7, 2, 0);
INSERT INTO `trx_surat_masuk_disp_users` VALUES (10, 9, 1, 0);
INSERT INTO `trx_surat_masuk_disp_users` VALUES (11, 10, 2, 0);
INSERT INTO `trx_surat_masuk_disp_users` VALUES (12, 11, 3, 0);
INSERT INTO `trx_surat_masuk_disp_users` VALUES (13, 12, 1, 0);
INSERT INTO `trx_surat_masuk_disp_users` VALUES (14, 12, 2, 0);
INSERT INTO `trx_surat_masuk_disp_users` VALUES (15, 12, 3, 0);
INSERT INTO `trx_surat_masuk_disp_users` VALUES (16, 12, 4, 0);
INSERT INTO `trx_surat_masuk_disp_users` VALUES (17, 12, 16, 0);

-- ----------------------------
-- Table structure for trx_surat_masuk_docs
-- ----------------------------
DROP TABLE IF EXISTS `trx_surat_masuk_docs`;
CREATE TABLE `trx_surat_masuk_docs`  (
  `tsmd_id` int(11) NOT NULL AUTO_INCREMENT,
  `tsmd_tsm_id` int(11) NULL DEFAULT NULL,
  `tsmd_orig` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tsmd_file` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tsmd_mime` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tsmd_size` double(15, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`tsmd_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_surat_masuk_docs
-- ----------------------------
INSERT INTO `trx_surat_masuk_docs` VALUES (1, 1, 'marley1209f.jpg', '2cab10be9e9b494fa5a6cdcd140bc87c.jpg', 'image/jpeg', 293030.00);
INSERT INTO `trx_surat_masuk_docs` VALUES (2, 1, 'marley1209g.jpg', 'd1222ff51e3349f0842ebc27ca7ee963.jpg', 'image/jpeg', 328357.00);
INSERT INTO `trx_surat_masuk_docs` VALUES (3, 3, 'marley1209g.jpg', '7017f7543b81415c997feae42866968d.jpg', 'image/jpeg', 328357.00);
INSERT INTO `trx_surat_masuk_docs` VALUES (4, 6, 'marley1209m.jpg', '18094a95c2274b6bbfae880e646190d5.jpg', 'image/jpeg', 292421.00);

-- ----------------------------
-- Table structure for trx_tasks
-- ----------------------------
DROP TABLE IF EXISTS `trx_tasks`;
CREATE TABLE `trx_tasks`  (
  `tt_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tt_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tt_flag` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tt_sp_id` bigint(20) NULL DEFAULT NULL,
  `tt_content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `tt_due_date` date NULL DEFAULT NULL,
  `tt_creator_id` bigint(20) NULL DEFAULT NULL,
  `tt_created_dt` datetime(0) NULL DEFAULT NULL,
  `tt_updated_dt` datetime(0) NULL DEFAULT NULL,
  `tt_updater_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`tt_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_tasks
-- ----------------------------
INSERT INTO `trx_tasks` VALUES (1, '15678 / A - 040 / 314 / 2018', 'Tahap Registrasi', 48, '\n                            <div class=\"item-content-group\">\n                                <div class=\"item-content-value\">Kementerian Dalam Negeri</div>\n                            </div> \n                        ', '2018-02-18', 1, '2018-02-17 14:31:26', '2018-02-17 19:50:55', 1);
INSERT INTO `trx_tasks` VALUES (2, '15627 / A - 040 / 314 / 2018', 'Tahap Registrasi', 48, '\n                            <div class=\"item-content-group\">\n                                <div class=\"item-content-value\">Kementerian Dalam Negeri</div>\n                            </div> \n                        ', '2018-02-18', 1, '2018-02-17 15:13:53', '2018-02-17 21:30:57', 1);
INSERT INTO `trx_tasks` VALUES (3, '15620 / A - 040 / 314 / 2018', 'Tahap Registrasi', 48, '\n                            <div class=\"item-content-group\">\n                                <div class=\"item-content-value\">Kementerian Dalam Negeri</div>\n                            </div> \n                        ', '2018-02-18', 1, '2018-02-17 15:25:04', '2018-02-17 21:26:28', 1);
INSERT INTO `trx_tasks` VALUES (4, 'A', 'Tahap Registrasi', 48, '\n                            <div class=\"item-content-group\">\n                                <div class=\"item-content-value\">Kementerian Dalam Negeri</div>\n                            </div> \n                        ', '2018-02-18', 1, '2018-02-17 20:37:31', '2018-02-17 20:53:53', 1);
INSERT INTO `trx_tasks` VALUES (5, '00056 / SK / 040 / 212 / 2018', 'Tahap Pembuatan', 47, '\n                            <div class=\"item-content-group\">\n                                <div class=\"item-content-value\">Kementerian Dalam Negeri Republik Indonesia</div>\n                            </div>\n                        ', '2018-02-18', 1, '2018-02-17 21:28:10', '2018-02-17 23:14:58', 1);
INSERT INTO `trx_tasks` VALUES (7, '002/800-SMKN.5/VII/2017', 'Tahap Registrasi', 48, '\n                            <div class=\"item-content-group\">\n                                <div class=\"item-content-value\">Kementerian Dalam Negeri</div>\n                            </div> \n                        ', '2018-02-19', 1, '2018-02-18 22:46:04', '2018-02-18 23:35:21', 1);
INSERT INTO `trx_tasks` VALUES (8, '00058/040-PDM/II/2018', 'Tahap Pembuatan', 47, '\n                            <div class=\"item-content-group\">\n                                <div class=\"item-content-value\">Kementerian Dalam Negeri Republik Indonesia</div>\n                            </div>\n                        ', '2018-02-20', 1, '2018-02-19 03:07:33', '2018-02-19 03:19:47', 1);

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
) ENGINE = InnoDB AUTO_INCREMENT = 88 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_tasks_activities
-- ----------------------------
INSERT INTO `trx_tasks_activities` VALUES (1, 2, 'update', 1, '2018-02-17 16:00:23', 'B', NULL);
INSERT INTO `trx_tasks_activities` VALUES (2, 2, 'add_label', 1, '2018-02-17 16:00:23', '[\"12\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (3, 2, 'update', 1, '2018-02-17 16:06:51', 'B', NULL);
INSERT INTO `trx_tasks_activities` VALUES (4, 2, 'update', 1, '2018-02-17 16:07:12', 'B', NULL);
INSERT INTO `trx_tasks_activities` VALUES (5, 2, 'update', 1, '2018-02-17 16:07:51', 'B', NULL);
INSERT INTO `trx_tasks_activities` VALUES (6, 2, 'remove_label', 1, '2018-02-17 16:07:51', '[12]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (7, 2, 'remove_label', 1, '2018-02-17 16:09:54', '[18]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (8, 2, 'add_label', 1, '2018-02-17 16:10:02', '[\"11\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (9, 2, 'add_label', 1, '2018-02-17 16:15:19', '[\"13\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (10, 3, 'add_label', 1, '2018-02-17 16:17:22', '[\"12\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (11, 1, 'add_label', 1, '2018-02-17 16:17:49', '[\"13\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (12, 3, 'add_label', 1, '2018-02-17 16:17:58', '[\"15\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (13, 2, 'update', 1, '2018-02-17 16:18:30', 'B / SM / 2015', NULL);
INSERT INTO `trx_tasks_activities` VALUES (14, 2, 'update', 1, '2018-02-17 16:18:52', '15627 / A - 040 / 3.15 / 2018', NULL);
INSERT INTO `trx_tasks_activities` VALUES (15, 3, 'update', 1, '2018-02-17 16:19:41', '15620 / A - 040 / 3.15 / 2018', NULL);
INSERT INTO `trx_tasks_activities` VALUES (16, 1, 'update', 1, '2018-02-17 16:21:37', '15678 / A - 040 / 3.15 / 2018', NULL);
INSERT INTO `trx_tasks_activities` VALUES (17, 3, 'update', 1, '2018-02-17 16:23:41', '15620 / A - 040 / 3.15 / 2018', NULL);
INSERT INTO `trx_tasks_activities` VALUES (18, 2, 'update', 1, '2018-02-17 16:23:47', '15627 / A - 040 / 3.15 / 2018', NULL);
INSERT INTO `trx_tasks_activities` VALUES (19, 1, 'update', 1, '2018-02-17 16:23:53', '15678 / A - 040 / 3.15 / 2018', NULL);
INSERT INTO `trx_tasks_activities` VALUES (20, 3, 'remove_label', 1, '2018-02-17 16:24:09', '[15]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (21, 2, 'remove_label', 1, '2018-02-17 16:24:16', '[11]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (22, 1, 'add_label', 1, '2018-02-17 16:24:36', '[\"11\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (23, 1, 'remove_label', 1, '2018-02-17 16:24:39', '[13]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (24, 3, 'update', 1, '2018-02-17 16:25:07', '15620 / A - 040 / 314 / 2018', NULL);
INSERT INTO `trx_tasks_activities` VALUES (25, 2, 'update', 1, '2018-02-17 16:25:16', '15627 / A - 040 / 314 / 2018', NULL);
INSERT INTO `trx_tasks_activities` VALUES (26, 1, 'update', 1, '2018-02-17 16:25:24', '15678 / A - 040 / 314 / 2018', NULL);
INSERT INTO `trx_tasks_activities` VALUES (27, 1, 'update_status', 1, '2018-02-17 16:48:12', '[\"Tahap Surat Dibaca\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (28, 3, 'update', 1, '2018-02-17 17:40:52', '15620 / A - 040 / 314 / 2018', NULL);
INSERT INTO `trx_tasks_activities` VALUES (29, 3, 'update_status', 1, '2018-02-17 17:41:06', '[\"Tahap Kodefikasi\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (30, 3, 'update', 1, '2018-02-17 17:43:49', '15620 / A - 040 / 314 / 2018', NULL);
INSERT INTO `trx_tasks_activities` VALUES (31, 3, 'update_status', 1, '2018-02-17 17:43:58', '[\"Tahap Scan\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (32, 3, 'update_status', 1, '2018-02-17 17:45:58', '[\"Tahap Surat Dibaca\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (33, 3, 'update', 1, '2018-02-17 18:58:07', '15620 / A - 040 / 314 / 2018', NULL);
INSERT INTO `trx_tasks_activities` VALUES (34, 3, 'update', 1, '2018-02-17 19:41:06', '15620 / A - 040 / 314 / 2018', NULL);
INSERT INTO `trx_tasks_activities` VALUES (35, 3, 'update_status', 1, '2018-02-17 19:47:12', '[\"Tahap Disposisi\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (36, 1, 'update_status', 1, '2018-02-17 19:50:55', '[\"Arsip Surat Masuk\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (37, 2, 'update_status', 1, '2018-02-17 20:09:14', '[\"Tahap Scan\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (38, 2, 'update_status', 1, '2018-02-17 20:09:26', '[\"Tahap Surat Dibaca\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (39, 2, 'update_status', 1, '2018-02-17 20:09:48', '[\"Tahap Disposisi\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (40, 4, 'create', 1, '2018-02-17 20:37:31', 'A', NULL);
INSERT INTO `trx_tasks_activities` VALUES (41, 4, 'update_status', 1, '2018-02-17 20:37:40', '[\"Tahap Kodefikasi\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (42, 4, 'update_status', 1, '2018-02-17 20:37:52', '[\"Tahap Scan\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (43, 4, 'update_status', 1, '2018-02-17 20:37:58', '[\"Tahap Surat Dibaca\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (44, 4, 'update_status', 1, '2018-02-17 20:38:33', '[\"Tahap Disposisi\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (45, 4, 'update_status', 1, '2018-02-17 20:53:53', '[\"Arsip Surat Masuk\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (46, 3, 'update_status', 1, '2018-02-17 20:56:29', '[\"Tahap Balas Surat\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (47, 3, 'update_status', 1, '2018-02-17 21:26:29', '[\"Arsip Surat Masuk\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (48, 5, 'create', 1, '2018-02-17 21:28:10', 'ABC', NULL);
INSERT INTO `trx_tasks_activities` VALUES (49, 5, 'update', 1, '2018-02-17 21:28:49', 'ABC', NULL);
INSERT INTO `trx_tasks_activities` VALUES (50, 5, 'update', 1, '2018-02-17 21:29:52', 'ABC', NULL);
INSERT INTO `trx_tasks_activities` VALUES (51, 5, 'update', 1, '2018-02-17 21:30:16', '00056 / SK / 040 / 212 / 2018', NULL);
INSERT INTO `trx_tasks_activities` VALUES (52, 2, 'update_status', 1, '2018-02-17 21:30:36', '[\"Tahap Balas Surat\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (53, 2, 'update_status', 1, '2018-02-17 21:30:58', '[\"Arsip Surat Masuk\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (54, 5, 'update_status', 1, '2018-02-17 23:05:28', '[\"Tahap Koreksi Eselon IV\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (55, 5, 'update', 1, '2018-02-17 23:06:54', '00056 / SK / 040 / 212 / 2018', NULL);
INSERT INTO `trx_tasks_activities` VALUES (56, 5, 'update_status', 1, '2018-02-17 23:07:24', '[\"Tahap Koreksi Eselon III\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (57, 5, 'update_status', 1, '2018-02-17 23:09:12', '[\"Tahap Koreksi Kapus\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (58, 5, 'update_status', 1, '2018-02-17 23:09:29', '[\"Tahap Paraf Kapus\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (59, 5, 'update_status', 1, '2018-02-17 23:09:58', '[\"Tahap Cetak\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (60, 5, 'update_status', 1, '2018-02-17 23:11:36', '[\"Tahap Pengiriman\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (61, 5, 'update_status', 1, '2018-02-17 23:12:40', '[\"Tahap Konfirmasi\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (62, 5, 'update_status', 1, '2018-02-17 23:14:58', '[\"Arsip Surat Keluar\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (65, 7, 'create', 1, '2018-02-18 22:46:04', '002/800-SMKN.5/VII/2017', NULL);
INSERT INTO `trx_tasks_activities` VALUES (66, 7, 'update', 1, '2018-02-18 22:47:01', '002/800-SMKN.5/VII/2017', NULL);
INSERT INTO `trx_tasks_activities` VALUES (67, 7, 'update', 1, '2018-02-18 22:47:08', '002/800-SMKN.5/VII/2017', NULL);
INSERT INTO `trx_tasks_activities` VALUES (68, 7, 'update_status', 1, '2018-02-18 22:47:12', '[\"Tahap Kodefikasi\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (69, 7, 'update', 1, '2018-02-18 22:49:15', '002/800-SMKN.5/VII/2017', NULL);
INSERT INTO `trx_tasks_activities` VALUES (70, 7, 'update_status', 1, '2018-02-18 22:49:37', '[\"Tahap Scan\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (71, 7, 'update', 1, '2018-02-18 22:51:20', '002/800-SMKN.5/VII/2017', NULL);
INSERT INTO `trx_tasks_activities` VALUES (72, 7, 'update_status', 1, '2018-02-18 23:18:06', '[\"Tahap Surat Dibaca\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (74, 7, 'update', 1, '2018-02-18 23:22:48', '002/800-SMKN.5/VII/2017', NULL);
INSERT INTO `trx_tasks_activities` VALUES (75, 7, 'update_status', 1, '2018-02-18 23:27:15', '[\"Tahap Disposisi\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (76, 7, 'update', 1, '2018-02-18 23:30:14', '002/800-SMKN.5/VII/2017', NULL);
INSERT INTO `trx_tasks_activities` VALUES (77, 7, 'update_status', 1, '2018-02-18 23:35:21', '[\"Arsip Surat Masuk\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (78, 8, 'create', 1, '2018-02-19 03:07:33', '00058/040-PDM/II/2018', NULL);
INSERT INTO `trx_tasks_activities` VALUES (79, 8, 'update', 1, '2018-02-19 03:07:50', '00058/040-PDM/II/2018', NULL);
INSERT INTO `trx_tasks_activities` VALUES (80, 8, 'update_status', 1, '2018-02-19 03:07:55', '[\"Tahap Koreksi Eselon IV\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (81, 8, 'update_status', 1, '2018-02-19 03:09:27', '[\"Tahap Koreksi Eselon III\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (82, 8, 'update_status', 1, '2018-02-19 03:10:23', '[\"Tahap Koreksi Kapus\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (83, 8, 'update_status', 1, '2018-02-19 03:11:21', '[\"Tahap Paraf Kapus\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (84, 8, 'update_status', 1, '2018-02-19 03:12:19', '[\"Tahap Cetak\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (85, 8, 'update_status', 1, '2018-02-19 03:16:39', '[\"Tahap Pengiriman\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (86, 8, 'update_status', 1, '2018-02-19 03:18:17', '[\"Tahap Konfirmasi\"]', NULL);
INSERT INTO `trx_tasks_activities` VALUES (87, 8, 'update_status', 1, '2018-02-19 03:19:47', '[\"Arsip Surat Keluar\"]', NULL);

-- ----------------------------
-- Table structure for trx_tasks_comments
-- ----------------------------
DROP TABLE IF EXISTS `trx_tasks_comments`;
CREATE TABLE `trx_tasks_comments`  (
  `ttc_tt_id` bigint(20) NULL DEFAULT NULL,
  `ttc_sender` bigint(20) NULL DEFAULT NULL,
  `ttc_message` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ttc_id` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ttc_id`) USING BTREE
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
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_tasks_labels
-- ----------------------------
INSERT INTO `trx_tasks_labels` VALUES (6, 2, 13);
INSERT INTO `trx_tasks_labels` VALUES (7, 3, 12);
INSERT INTO `trx_tasks_labels` VALUES (10, 1, 11);

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
  `tts_data_result` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `tts_deleted` int(11) NULL DEFAULT NULL,
  `tts_created` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`tts_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of trx_tasks_statuses
-- ----------------------------
INSERT INTO `trx_tasks_statuses` VALUES (1, 1, 696, 886, 'proses-surat-masuk', 1, '|date=2018-02-17|sender=Kementerian Dalam Negeri|receiver=Kepala Pusdiklat Tenaga Administrasi|result=1;2018-02-17;1;A;2018-02-17;Pelaksanaan;Kementerian Dalam Negeri;Kepala Pusdiklat Tenaga Administrasi;Bagian Umum;-;17 Feb 2018;17 Feb 2018;Administrator|', 1, '2018-02-17 14:31:26');
INSERT INTO `trx_tasks_statuses` VALUES (2, 1, 697, 887, 'proses-surat-masuk', 1, '|date=2018-02-17|sender=Kementerian Dalam Negeri|receiver=Kepala Pusdiklat Tenaga Administrasi|result=1;00040;2018-02-17;1;00040 / 040 / 212 / 2018;4;A;2018-02-17;Pelaksanaan;Kementerian Dalam Negeri;Kepala Pusdiklat Tenaga Administrasi;Bagian Umum;-;17 Feb 2018;17 Feb 2018;Administrator;Perpustakaan / Dokumen / Kearsipan / Sandi;040 - Perpustakaan / Dokumen / Kearsipan / Sandi|', 1, '2018-02-17 14:35:05');
INSERT INTO `trx_tasks_statuses` VALUES (3, 1, 698, 888, 'proses-surat-masuk', 1, '|date=2018-02-17|sender=Kementerian Dalam Negeri|receiver=Kepala Pusdiklat Tenaga Administrasi|result=1;00040;2018-02-17;1;00040 / 040 / 212 / 2018;4;15678 / A - 040 / 314 / 2018;2018-02-17;Pelaksanaan;Kementerian Dalam Negeri;Kepala Pusdiklat Tenaga Administrasi;Bagian Umum;-;17 Feb 2018;17 Feb 2018;Administrator;Perpustakaan / Dokumen / Kearsipan / Sandi;040 - Perpustakaan / Dokumen / Kearsipan / Sandi|', 1, '2018-02-17 14:37:54');
INSERT INTO `trx_tasks_statuses` VALUES (4, 2, 696, 886, 'proses-surat-masuk', 2, '|date=2018-02-17|sender=Kementerian Dalam Negeri|receiver=Kepala Pusdiklat Tenaga Administrasi|result=2;2018-02-17;1;B;2018-02-17;Undangan;Kementerian Dalam Negeri;Kepala Pusdiklat Tenaga Administrasi;Bagian Umum;-;17 Feb 2018;17 Feb 2018;Administrator|', 1, '2018-02-17 15:13:53');
INSERT INTO `trx_tasks_statuses` VALUES (5, 3, 696, 886, 'proses-surat-masuk', 3, '|date=2018-02-17|sender=Kementerian Dalam Negeri|receiver=Kepala Pusdiklat Tenaga Administrasi|result=3;00044;2018-02-17;1;15620 / A - 040 / 314 / 2018;2018-02-17;Undangan;Kementerian Dalam Negeri;Kepala Pusdiklat Tenaga Administrasi;Bagian Umum;-;17 Feb 2018;17 Feb 2018;Administrator|', 1, '2018-02-17 15:25:05');
INSERT INTO `trx_tasks_statuses` VALUES (6, 2, 697, 887, 'proses-surat-masuk', 2, '|date=2018-02-17|sender=Kementerian Dalam Negeri|receiver=Kepala Pusdiklat Tenaga Administrasi|result=2;00041;2018-02-17;1;00041 / A - 040 / 212 / 2018;4;15627 / A - 040 / 314 / 2018;2018-02-17;Undangan;Kementerian Dalam Negeri;Kepala Pusdiklat Tenaga Administrasi;Bagian Umum;-;17 Feb 2018;17 Feb 2018;Administrator;Perpustakaan / Dokumen / Kearsipan / Sandi;040 - Perpustakaan / Dokumen / Kearsipan / Sandi|', 1, '2018-02-17 15:25:32');
INSERT INTO `trx_tasks_statuses` VALUES (7, 1, 699, 889, 'proses-surat-masuk', 1, '|date=2018-02-17|sender=Kementerian Dalam Negeri|receiver=Kepala Pusdiklat Tenaga Administrasi|result=1;00040;2018-02-17;1;00040 / 040 / 212 / 2018;4;15678 / A - 040 / 314 / 2018;2018-02-17;Pelaksanaan;Kementerian Dalam Negeri;Kepala Pusdiklat Tenaga Administrasi;Bagian Umum;-;17 Feb 2018;17 Feb 2018;Administrator;Perpustakaan / Dokumen / Kearsipan / Sandi;040 - Perpustakaan / Dokumen / Kearsipan / Sandi|', 1, '2018-02-17 16:48:12');
INSERT INTO `trx_tasks_statuses` VALUES (8, 3, 697, 887, 'proses-surat-masuk', 3, '|date=2018-02-17|sender=Kementerian Dalam Negeri|receiver=Kepala Pusdiklat Tenaga Administrasi|result=3;00044;2018-02-17;1;15620 / A - 040 / 314 / 2018;2;15620 / A - 040 / 314 / 2018;2018-02-17;Undangan;Kementerian Dalam Negeri;Kepala Pusdiklat Tenaga Administrasi;Bagian Umum;-;17 Feb 2018;17 Feb 2018;Administrator;Urusan Dalam;010 - Urusan Dalam|', 1, '2018-02-17 17:41:06');
INSERT INTO `trx_tasks_statuses` VALUES (9, 3, 698, 888, 'proses-surat-masuk', 3, '|date=2018-02-17|sender=Kementerian Dalam Negeri|receiver=Kepala Pusdiklat Tenaga Administrasi|result=3;00044;2018-02-17;1;15620 / A - 040 / 314 / 2018;2;15620 / A - 040 / 314 / 2018;2018-02-17;Undangan;Kementerian Dalam Negeri;Kepala Pusdiklat Tenaga Administrasi;Bagian Umum;-;17 Feb 2018;17 Feb 2018;Administrator;Urusan Dalam;010 - Urusan Dalam|', 1, '2018-02-17 17:43:58');
INSERT INTO `trx_tasks_statuses` VALUES (10, 3, 699, 889, 'proses-surat-masuk', 3, '|date=2018-02-17|sender=Kementerian Dalam Negeri|receiver=Kepala Pusdiklat Tenaga Administrasi|result=3;00044;2018-02-17;1;15620 / A - 040 / 314 / 2018;2;15620 / A - 040 / 314 / 2018;2018-02-17;Undangan;Kementerian Dalam Negeri;Kepala Pusdiklat Tenaga Administrasi;Bagian Umum;-;17 Feb 2018;17 Feb 2018;Administrator;Urusan Dalam;010 - Urusan Dalam|', 1, '2018-02-17 17:45:58');
INSERT INTO `trx_tasks_statuses` VALUES (11, 3, 700, 890, 'proses-surat-masuk', 3, '|date=2018-02-17|sender=Kementerian Dalam Negeri|receiver=Kepala Pusdiklat Tenaga Administrasi|result=3;00044;2018-02-17;1;15620 / A - 040 / 314 / 2018;2;15620 / A - 040 / 314 / 2018;2018-02-17;Undangan;Kementerian Dalam Negeri;Kepala Pusdiklat Tenaga Administrasi;Bagian Umum;DISPOSITION;-;17 Feb 2018;17 Feb 2018;Administrator;Urusan Dalam;010 - Urusan Dalam|', 1, '2018-02-17 19:47:12');
INSERT INTO `trx_tasks_statuses` VALUES (12, 1, 710, 892, 'proses-surat-masuk', 1, '|date=2018-02-17|sender=Kementerian Dalam Negeri|receiver=Kepala Pusdiklat Tenaga Administrasi|result=1;00040;2018-02-17;1;00040 / 040 / 212 / 2018;4;15678 / A - 040 / 314 / 2018;2018-02-17;Pelaksanaan;Kementerian Dalam Negeri;Kepala Pusdiklat Tenaga Administrasi;Bagian Umum;ARCHIVED;-;17 Feb 2018;17 Feb 2018;Administrator;Perpustakaan / Dokumen / Kearsipan / Sandi;040 - Perpustakaan / Dokumen / Kearsipan / Sandi|', 0, '2018-02-17 19:50:55');
INSERT INTO `trx_tasks_statuses` VALUES (13, 2, 698, 888, 'proses-surat-masuk', 2, '|date=2018-02-17|sender=Kementerian Dalam Negeri|receiver=Kepala Pusdiklat Tenaga Administrasi|result=2;00041;2018-02-17;1;00041 / A - 040 / 212 / 2018;4;15627 / A - 040 / 314 / 2018;2018-02-17;Undangan;Kementerian Dalam Negeri;Kepala Pusdiklat Tenaga Administrasi;Bagian Umum;-;17 Feb 2018;17 Feb 2018;Administrator;Perpustakaan / Dokumen / Kearsipan / Sandi;040 - Perpustakaan / Dokumen / Kearsipan / Sandi|', 1, '2018-02-17 20:09:14');
INSERT INTO `trx_tasks_statuses` VALUES (14, 2, 699, 889, 'proses-surat-masuk', 2, '|date=2018-02-17|sender=Kementerian Dalam Negeri|receiver=Kepala Pusdiklat Tenaga Administrasi|result=2;00041;2018-02-17;1;00041 / A - 040 / 212 / 2018;4;15627 / A - 040 / 314 / 2018;2018-02-17;Undangan;Kementerian Dalam Negeri;Kepala Pusdiklat Tenaga Administrasi;Bagian Umum;-;17 Feb 2018;17 Feb 2018;Administrator;Perpustakaan / Dokumen / Kearsipan / Sandi;040 - Perpustakaan / Dokumen / Kearsipan / Sandi|', 1, '2018-02-17 20:09:26');
INSERT INTO `trx_tasks_statuses` VALUES (15, 2, 700, 890, 'proses-surat-masuk', 2, '|date=2018-02-17|sender=Kementerian Dalam Negeri|receiver=Kepala Pusdiklat Tenaga Administrasi|result=2;00041;2018-02-17;1;00041 / A - 040 / 212 / 2018;4;15627 / A - 040 / 314 / 2018;2018-02-17;Undangan;Kementerian Dalam Negeri;Kepala Pusdiklat Tenaga Administrasi;Bagian Umum;DISPOSITION;-;17 Feb 2018;17 Feb 2018;Administrator;Perpustakaan / Dokumen / Kearsipan / Sandi;040 - Perpustakaan / Dokumen / Kearsipan / Sandi|', 1, '2018-02-17 20:09:48');
INSERT INTO `trx_tasks_statuses` VALUES (16, 4, 696, 886, 'proses-surat-masuk', 4, '|date=2018-02-17|sender=Kementerian Dalam Negeri|receiver=Kepala Pusdiklat Tenaga Administrasi|result=4;00045;2018-02-17;1;A;2018-02-17;Undangan;Kementerian Dalam Negeri;Kepala Pusdiklat Tenaga Administrasi;Bagian Umum;-;17 Feb 2018;17 Feb 2018;Administrator|', 1, '2018-02-17 20:37:32');
INSERT INTO `trx_tasks_statuses` VALUES (17, 4, 697, 887, 'proses-surat-masuk', 4, '|date=2018-02-17|sender=Kementerian Dalam Negeri|receiver=Kepala Pusdiklat Tenaga Administrasi|result=4;00045;2018-02-17;1;A;2018-02-17;Undangan;Kementerian Dalam Negeri;Kepala Pusdiklat Tenaga Administrasi;Bagian Umum;-;17 Feb 2018;17 Feb 2018;Administrator|', 1, '2018-02-17 20:37:40');
INSERT INTO `trx_tasks_statuses` VALUES (18, 4, 698, 888, 'proses-surat-masuk', 4, '|date=2018-02-17|sender=Kementerian Dalam Negeri|receiver=Kepala Pusdiklat Tenaga Administrasi|result=4;00045;2018-02-17;1;A;1;A;2018-02-17;Undangan;Kementerian Dalam Negeri;Kepala Pusdiklat Tenaga Administrasi;Bagian Umum;-;17 Feb 2018;17 Feb 2018;Administrator;UMUM;000 - UMUM|', 1, '2018-02-17 20:37:52');
INSERT INTO `trx_tasks_statuses` VALUES (19, 4, 699, 889, 'proses-surat-masuk', 4, '|date=2018-02-17|sender=Kementerian Dalam Negeri|receiver=Kepala Pusdiklat Tenaga Administrasi|result=4;00045;2018-02-17;1;A;1;A;2018-02-17;Undangan;Kementerian Dalam Negeri;Kepala Pusdiklat Tenaga Administrasi;Bagian Umum;-;17 Feb 2018;17 Feb 2018;Administrator;UMUM;000 - UMUM|', 1, '2018-02-17 20:37:58');
INSERT INTO `trx_tasks_statuses` VALUES (20, 4, 700, 890, 'proses-surat-masuk', 4, '|date=2018-02-17|sender=Kementerian Dalam Negeri|receiver=Kepala Pusdiklat Tenaga Administrasi|result=4;00045;2018-02-17;1;A;1;A;2018-02-17;Undangan;Kementerian Dalam Negeri;Kepala Pusdiklat Tenaga Administrasi;Bagian Umum;DISPOSITION;-;17 Feb 2018;17 Feb 2018;Administrator;UMUM;000 - UMUM|', 1, '2018-02-17 20:38:33');
INSERT INTO `trx_tasks_statuses` VALUES (21, 4, 711, 892, 'proses-surat-masuk', 4, '|date=2018-02-17|sender=Kementerian Dalam Negeri|receiver=Kepala Pusdiklat Tenaga Administrasi|result=4;00045;2018-02-17;1;A;1;A;2018-02-17;Undangan;Kementerian Dalam Negeri;Kepala Pusdiklat Tenaga Administrasi;Bagian Umum;ARCHIVED;-;17 Feb 2018;17 Feb 2018;Administrator;UMUM;000 - UMUM|', 0, '2018-02-17 20:53:53');
INSERT INTO `trx_tasks_statuses` VALUES (22, 3, 701, 891, 'proses-surat-masuk', 3, '|date=2018-02-17|sender=Kementerian Dalam Negeri|receiver=Kepala Pusdiklat Tenaga Administrasi|result=3;00044;2018-02-17;1;15620 / A - 040 / 314 / 2018;2;15620 / A - 040 / 314 / 2018;2018-02-17;Undangan;Kementerian Dalam Negeri;Kepala Pusdiklat Tenaga Administrasi;Bagian Umum;REPLY;-;17 Feb 2018;17 Feb 2018;Administrator;Urusan Dalam;010 - Urusan Dalam|', 1, '2018-02-17 20:56:29');
INSERT INTO `trx_tasks_statuses` VALUES (23, 3, 702, 892, 'proses-surat-masuk', 3, '|date=2018-02-17|sender=Kementerian Dalam Negeri|receiver=Kepala Pusdiklat Tenaga Administrasi|result=3;00044;2018-02-17;1;15620 / A - 040 / 314 / 2018;2;15620 / A - 040 / 314 / 2018;2018-02-17;Undangan;Kementerian Dalam Negeri;Kepala Pusdiklat Tenaga Administrasi;Bagian Umum;REPLY;-;17 Feb 2018;17 Feb 2018;Administrator;Urusan Dalam;010 - Urusan Dalam|', 0, '2018-02-17 21:26:29');
INSERT INTO `trx_tasks_statuses` VALUES (24, 5, 683, 884, 'proses-surat-keluar', 1, '|date=2018-02-17|sender=Kepala Pusdiklat Tenaga Administrasi|receiver=Kementerian Dalam Negeri Republik Indonesia|result=1;00056 / SK / 040 / 212 / 2018;2018-02-17;2018-02-17;1;-;00056;Kepala Pusdiklat Tenaga Administrasi;Kementerian Dalam Negeri Republik Indonesia;Undangan;17 Feb 2018;17 Feb 2018;UMUM;000 - UMUM;01 Jan 1970;01 Jan 1970;01 Jan 1970;01 Jan 1970;01 Jan 1970|', 1, '2018-02-17 21:28:10');
INSERT INTO `trx_tasks_statuses` VALUES (25, 2, 701, 891, 'proses-surat-masuk', 2, '|date=2018-02-17|sender=Kementerian Dalam Negeri|receiver=Kepala Pusdiklat Tenaga Administrasi|result=2;00041;2018-02-17;1;00041 / A - 040 / 212 / 2018;4;15627 / A - 040 / 314 / 2018;2018-02-17;Undangan;Kementerian Dalam Negeri;Kepala Pusdiklat Tenaga Administrasi;Bagian Umum;REPLY;-;17 Feb 2018;17 Feb 2018;Administrator;Perpustakaan / Dokumen / Kearsipan / Sandi;040 - Perpustakaan / Dokumen / Kearsipan / Sandi|', 1, '2018-02-17 21:30:36');
INSERT INTO `trx_tasks_statuses` VALUES (26, 2, 702, 892, 'proses-surat-masuk', 2, '|date=2018-02-17|sender=Kementerian Dalam Negeri|receiver=Kepala Pusdiklat Tenaga Administrasi|result=2;00041;2018-02-17;1;00041 / A - 040 / 212 / 2018;4;15627 / A - 040 / 314 / 2018;2018-02-17;Undangan;Kementerian Dalam Negeri;Kepala Pusdiklat Tenaga Administrasi;Bagian Umum;REPLY;00056 / SK / 040 / 212 / 2018;-;17 Feb 2018;17 Feb 2018;Administrator;Perpustakaan / Dokumen / Kearsipan / Sandi;040 - Perpustakaan / Dokumen / Kearsipan / Sandi|', 0, '2018-02-17 21:30:57');
INSERT INTO `trx_tasks_statuses` VALUES (27, 5, 684, 876, 'proses-surat-keluar', 1, '|date=2018-02-17|sender=Kepala Pusdiklat Tenaga Administrasi|receiver=Kementerian Dalam Negeri Republik Indonesia|result=1;00056 / SK / 040 / 212 / 2018;2018-02-17;2018-02-17;1;-;00056;Kepala Pusdiklat Tenaga Administrasi;Kementerian Dalam Negeri Republik Indonesia;Undangan;1;2018-02-17;17 Feb 2018;17 Feb 2018;UMUM;000 - UMUM;17 Feb 2018;01 Jan 1970;01 Jan 1970;01 Jan 1970;01 Jan 1970;Administrator|', 1, '2018-02-17 23:05:28');
INSERT INTO `trx_tasks_statuses` VALUES (28, 5, 685, 877, 'proses-surat-keluar', 1, '|date=2018-02-17|sender=Kepala Pusdiklat Tenaga Administrasi|receiver=Kementerian Dalam Negeri Republik Indonesia|result=1;00056 / SK / 040 / 212 / 2018;2018-02-17;2018-02-17;1;-;00056;Kepala Pusdiklat Tenaga Administrasi;Kementerian Dalam Negeri Republik Indonesia;Undangan;1;2018-02-17;APPROVED;17 Feb 2018;17 Feb 2018;UMUM;000 - UMUM;17 Feb 2018;01 Jan 1970;01 Jan 1970;01 Jan 1970;01 Jan 1970;Administrator;Dokumen disetujui|', 1, '2018-02-17 23:07:24');
INSERT INTO `trx_tasks_statuses` VALUES (29, 5, 686, 878, 'proses-surat-keluar', 1, '|date=2018-02-17|sender=Kepala Pusdiklat Tenaga Administrasi|receiver=Kementerian Dalam Negeri Republik Indonesia|result=1;00056 / SK / 040 / 212 / 2018;2018-02-17;2018-02-17;1;-;00056;Kepala Pusdiklat Tenaga Administrasi;Kementerian Dalam Negeri Republik Indonesia;Undangan;1;2018-02-17;APPROVED;1;2018-02-17;APPROVED;17 Feb 2018;17 Feb 2018;UMUM;000 - UMUM;17 Feb 2018;17 Feb 2018;01 Jan 1970;01 Jan 1970;01 Jan 1970;Administrator;Dokumen disetujui;Administrator;Dokumen disetujui|', 1, '2018-02-17 23:09:12');
INSERT INTO `trx_tasks_statuses` VALUES (30, 5, 687, 879, 'proses-surat-keluar', 1, '|date=2018-02-17|sender=Kepala Pusdiklat Tenaga Administrasi|receiver=Kementerian Dalam Negeri Republik Indonesia|result=1;00056 / SK / 040 / 212 / 2018;2018-02-17;2018-02-17;1;-;00056;Kepala Pusdiklat Tenaga Administrasi;Kementerian Dalam Negeri Republik Indonesia;Undangan;1;2018-02-17;APPROVED;1;2018-02-17;APPROVED;1;2018-02-17;APPROVED;17 Feb 2018;17 Feb 2018;UMUM;000 - UMUM;17 Feb 2018;17 Feb 2018;17 Feb 2018;01 Jan 1970;01 Jan 1970;Administrator;Dokumen disetujui;Administrator;Dokumen disetujui;Administrator;Dokumen disetujui|', 1, '2018-02-17 23:09:29');
INSERT INTO `trx_tasks_statuses` VALUES (31, 5, 688, 880, 'proses-surat-keluar', 1, '|date=2018-02-17|sender=Kepala Pusdiklat Tenaga Administrasi|receiver=Kementerian Dalam Negeri Republik Indonesia|result=1;00056 / SK / 040 / 212 / 2018;2018-02-17;2018-02-17;1;-;00056;Kepala Pusdiklat Tenaga Administrasi;Kementerian Dalam Negeri Republik Indonesia;Undangan;1;2018-02-17;APPROVED;1;2018-02-17;APPROVED;1;2018-02-17;APPROVED;1;2018-02-17;17 Feb 2018;17 Feb 2018;UMUM;000 - UMUM;17 Feb 2018;17 Feb 2018;17 Feb 2018;17 Feb 2018;01 Jan 1970;Administrator;Dokumen disetujui;Administrator;Dokumen disetujui;Administrator;Dokumen disetujui;Administrator|', 1, '2018-02-17 23:09:58');
INSERT INTO `trx_tasks_statuses` VALUES (32, 5, 689, 881, 'proses-surat-keluar', 1, '|date=2018-02-17|sender=Kepala Pusdiklat Tenaga Administrasi|receiver=Kementerian Dalam Negeri Republik Indonesia|result=1;00056 / SK / 040 / 212 / 2018;2018-02-17;2018-02-17;1;-;00056;Kepala Pusdiklat Tenaga Administrasi;Kementerian Dalam Negeri Republik Indonesia;Undangan;1;2018-02-17;APPROVED;1;2018-02-17;APPROVED;1;2018-02-17;APPROVED;1;2018-02-17;17 Feb 2018;17 Feb 2018;UMUM;000 - UMUM;17 Feb 2018;17 Feb 2018;17 Feb 2018;17 Feb 2018;01 Jan 1970;Administrator;Dokumen disetujui;Administrator;Dokumen disetujui;Administrator;Dokumen disetujui;Administrator|', 1, '2018-02-17 23:11:36');
INSERT INTO `trx_tasks_statuses` VALUES (33, 5, 690, 882, 'proses-surat-keluar', 1, '|date=2018-02-17|sender=Kepala Pusdiklat Tenaga Administrasi|receiver=Kementerian Dalam Negeri Republik Indonesia|result=1;00056 / SK / 040 / 212 / 2018;2018-02-17;2018-02-17;1;-;00056;Kepala Pusdiklat Tenaga Administrasi;Kementerian Dalam Negeri Republik Indonesia;Undangan;1;2018-02-17;APPROVED;1;2018-02-17;APPROVED;1;2018-02-17;APPROVED;1;2018-02-17;2018-02-17;17 Feb 2018;17 Feb 2018;UMUM;000 - UMUM;17 Feb 2018;17 Feb 2018;17 Feb 2018;17 Feb 2018;17 Feb 2018;Administrator;Dokumen disetujui;Administrator;Dokumen disetujui;Administrator;Dokumen disetujui;Administrator|', 1, '2018-02-17 23:12:40');
INSERT INTO `trx_tasks_statuses` VALUES (34, 5, 707, 894, 'proses-surat-keluar', 1, '|date=2018-02-17|sender=Kepala Pusdiklat Tenaga Administrasi|receiver=Kementerian Dalam Negeri Republik Indonesia|result=1;00056 / SK / 040 / 212 / 2018;2018-02-17;2018-02-17;1;-;00056;Kepala Pusdiklat Tenaga Administrasi;Kementerian Dalam Negeri Republik Indonesia;Undangan;1;2018-02-17;APPROVED;1;2018-02-17;APPROVED;1;2018-02-17;APPROVED;1;2018-02-17;2018-02-17;DONE;17 Feb 2018;17 Feb 2018;UMUM;000 - UMUM;17 Feb 2018;17 Feb 2018;17 Feb 2018;17 Feb 2018;17 Feb 2018;Administrator;Dokumen disetujui;Administrator;Dokumen disetujui;Administrator;Dokumen disetujui;Administrator|', 0, '2018-02-17 23:14:58');
INSERT INTO `trx_tasks_statuses` VALUES (37, 7, 696, 886, 'proses-surat-masuk', 6, '|date=2018-02-18|sender=Kementerian Dalam Negeri|receiver=Kepala Pusdiklat Tenaga Administrasi|result=6;00046;2018-02-18;1;002/800-SMKN.5/VII/2017;2018-02-18;Undangan;Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.;Kementerian Dalam Negeri;Kepala Pusdiklat Tenaga Administrasi;Bagian Umum;-;18 Feb 2018;18 Feb 2018;Administrator|', 1, '2018-02-18 22:46:04');
INSERT INTO `trx_tasks_statuses` VALUES (38, 7, 697, 887, 'proses-surat-masuk', 6, '|date=2018-02-18|sender=Kementerian Dalam Negeri|receiver=Kepala Pusdiklat Tenaga Administrasi|result=6;00046;2018-02-18;1;00046/040-PDM/II/2018;4;002/800-SMKN.5/VII/2017;2018-02-18;Undangan;Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.;Kementerian Dalam Negeri;Kepala Pusdiklat Tenaga Administrasi;Bagian Umum;-;18 Feb 2018;18 Feb 2018;Administrator;Perpustakaan / Dokumen / Kearsipan / Sandi;040 - Perpustakaan / Dokumen / Kearsipan / Sandi|', 1, '2018-02-18 22:47:12');
INSERT INTO `trx_tasks_statuses` VALUES (39, 7, 698, 888, 'proses-surat-masuk', 6, '|date=2018-02-18|sender=Kementerian Dalam Negeri|receiver=Kepala Pusdiklat Tenaga Administrasi|result=6;00046;2018-02-18;1;00046/040-PDM/II/2018;4;002/800-SMKN.5/VII/2017;2018-02-18;Undangan;Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.;Kementerian Dalam Negeri;Kepala Pusdiklat Tenaga Administrasi;Bagian Umum;-;18 Feb 2018;18 Feb 2018;Administrator;Perpustakaan / Dokumen / Kearsipan / Sandi;040 - Perpustakaan / Dokumen / Kearsipan / Sandi|', 1, '2018-02-18 22:49:36');
INSERT INTO `trx_tasks_statuses` VALUES (40, 7, 699, 889, 'proses-surat-masuk', 6, '|date=2018-02-18|sender=Kementerian Dalam Negeri|receiver=Kepala Pusdiklat Tenaga Administrasi|result=6;00046;2018-02-18;1;00046/040-PDM/II/2018;4;002/800-SMKN.5/VII/2017;2018-02-18;Undangan;Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.;Kementerian Dalam Negeri;Kepala Pusdiklat Tenaga Administrasi;Bagian Umum;-;18 Feb 2018;18 Feb 2018;Administrator;Perpustakaan / Dokumen / Kearsipan / Sandi;040 - Perpustakaan / Dokumen / Kearsipan / Sandi|', 1, '2018-02-18 23:18:06');
INSERT INTO `trx_tasks_statuses` VALUES (42, 7, 700, 890, 'proses-surat-masuk', 6, '|date=2018-02-18|sender=Kementerian Dalam Negeri|receiver=Kepala Pusdiklat Tenaga Administrasi|result=6;00046;2018-02-18;1;00046/040-PDM/II/2018;4;002/800-SMKN.5/VII/2017;2018-02-18;Undangan;Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.;Kementerian Dalam Negeri;Kepala Pusdiklat Tenaga Administrasi;Bagian Umum;DISPOSITION;-;18 Feb 2018;18 Feb 2018;Administrator;Perpustakaan / Dokumen / Kearsipan / Sandi;040 - Perpustakaan / Dokumen / Kearsipan / Sandi|', 1, '2018-02-18 23:27:15');
INSERT INTO `trx_tasks_statuses` VALUES (43, 7, 711, 892, 'proses-surat-masuk', 6, '|date=2018-02-18|sender=Kementerian Dalam Negeri|receiver=Kepala Pusdiklat Tenaga Administrasi|result=6;00046;2018-02-18;1;00046/040-PDM/II/2018;4;002/800-SMKN.5/VII/2017;2018-02-18;Undangan;Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.;Kementerian Dalam Negeri;Kepala Pusdiklat Tenaga Administrasi;Bagian Umum;ARCHIVED;-;18 Feb 2018;18 Feb 2018;Administrator;Perpustakaan / Dokumen / Kearsipan / Sandi;040 - Perpustakaan / Dokumen / Kearsipan / Sandi|', 0, '2018-02-18 23:35:21');
INSERT INTO `trx_tasks_statuses` VALUES (44, 8, 683, 884, 'proses-surat-keluar', 2, '|date=2018-02-19|sender=Kepala Pusdiklat Tenaga Administrasi|receiver=Kementerian Dalam Negeri Republik Indonesia|result=2;00058/040-PDM/II/2018;2018-02-19;2018-02-19;1;4;-;00058;Kepala Pusdiklat Tenaga Administrasi;Kementerian Dalam Negeri Republik Indonesia;Undangan Rapat;Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.;Bagian Umum;19 Feb 2018;19 Feb 2018;Perpustakaan / Dokumen / Kearsipan / Sandi;040 - Perpustakaan / Dokumen / Kearsipan / Sandi;01 Jan 1970;01 Jan 1970;01 Jan 1970;01 Jan 1970;01 Jan 1970;Administrator|', 1, '2018-02-19 03:07:33');
INSERT INTO `trx_tasks_statuses` VALUES (45, 8, 684, 876, 'proses-surat-keluar', 2, '|date=2018-02-19|sender=Kepala Pusdiklat Tenaga Administrasi|receiver=Kementerian Dalam Negeri Republik Indonesia|result=2;00058/040-PDM/II/2018;2018-02-19;2018-02-19;1;4;-;00058;Kepala Pusdiklat Tenaga Administrasi;Kementerian Dalam Negeri Republik Indonesia;Undangan Rapat;Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.;Bagian Umum;19 Feb 2018;19 Feb 2018;Perpustakaan / Dokumen / Kearsipan / Sandi;040 - Perpustakaan / Dokumen / Kearsipan / Sandi;01 Jan 1970;01 Jan 1970;01 Jan 1970;01 Jan 1970;01 Jan 1970;Administrator|', 1, '2018-02-19 03:07:55');
INSERT INTO `trx_tasks_statuses` VALUES (46, 8, 685, 877, 'proses-surat-keluar', 2, '|date=2018-02-19|sender=Kepala Pusdiklat Tenaga Administrasi|receiver=Kementerian Dalam Negeri Republik Indonesia|result=2;00058/040-PDM/II/2018;2018-02-19;2018-02-19;1;4;-;00058;Kepala Pusdiklat Tenaga Administrasi;Kementerian Dalam Negeri Republik Indonesia;Undangan Rapat;Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.;1;2018-02-19;OKE;APPROVED;Bagian Umum;19 Feb 2018;19 Feb 2018;Perpustakaan / Dokumen / Kearsipan / Sandi;040 - Perpustakaan / Dokumen / Kearsipan / Sandi;19 Feb 2018;01 Jan 1970;01 Jan 1970;01 Jan 1970;01 Jan 1970;Administrator;Administrator;Dokumen disetujui|', 1, '2018-02-19 03:09:27');
INSERT INTO `trx_tasks_statuses` VALUES (47, 8, 686, 878, 'proses-surat-keluar', 2, '|date=2018-02-19|sender=Kepala Pusdiklat Tenaga Administrasi|receiver=Kementerian Dalam Negeri Republik Indonesia|result=2;00058/040-PDM/II/2018;2018-02-19;2018-02-19;1;4;-;00058;Kepala Pusdiklat Tenaga Administrasi;Kementerian Dalam Negeri Republik Indonesia;Undangan Rapat;Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.;1;2018-02-19;OKE;APPROVED;1;2018-02-19;OKE;APPROVED;Bagian Umum;19 Feb 2018;19 Feb 2018;Perpustakaan / Dokumen / Kearsipan / Sandi;040 - Perpustakaan / Dokumen / Kearsipan / Sandi;19 Feb 2018;19 Feb 2018;01 Jan 1970;01 Jan 1970;01 Jan 1970;Administrator;Administrator;Dokumen disetujui;Administrator;Dokumen disetujui|', 1, '2018-02-19 03:10:23');
INSERT INTO `trx_tasks_statuses` VALUES (48, 8, 687, 879, 'proses-surat-keluar', 2, '|date=2018-02-19|sender=Kepala Pusdiklat Tenaga Administrasi|receiver=Kementerian Dalam Negeri Republik Indonesia|result=2;00058/040-PDM/II/2018;2018-02-19;2018-02-19;1;4;-;00058;Kepala Pusdiklat Tenaga Administrasi;Kementerian Dalam Negeri Republik Indonesia;Undangan Rapat;Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.;1;2018-02-19;OKE;APPROVED;1;2018-02-19;OKE;APPROVED;1;2018-02-19;OKE;APPROVED;Bagian Umum;19 Feb 2018;19 Feb 2018;Perpustakaan / Dokumen / Kearsipan / Sandi;040 - Perpustakaan / Dokumen / Kearsipan / Sandi;19 Feb 2018;19 Feb 2018;19 Feb 2018;01 Jan 1970;01 Jan 1970;Administrator;Administrator;Dokumen disetujui;Administrator;Dokumen disetujui;Administrator;Dokumen disetujui|', 1, '2018-02-19 03:11:21');
INSERT INTO `trx_tasks_statuses` VALUES (49, 8, 688, 880, 'proses-surat-keluar', 2, '|date=2018-02-19|sender=Kepala Pusdiklat Tenaga Administrasi|receiver=Kementerian Dalam Negeri Republik Indonesia|result=2;00058/040-PDM/II/2018;2018-02-19;2018-02-19;1;4;-;00058;Kepala Pusdiklat Tenaga Administrasi;Kementerian Dalam Negeri Republik Indonesia;Undangan Rapat;Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.;1;2018-02-19;OKE;APPROVED;1;2018-02-19;OKE;APPROVED;1;2018-02-19;OKE;APPROVED;1;2018-02-19;Bagian Umum;19 Feb 2018;19 Feb 2018;Perpustakaan / Dokumen / Kearsipan / Sandi;040 - Perpustakaan / Dokumen / Kearsipan / Sandi;19 Feb 2018;19 Feb 2018;19 Feb 2018;19 Feb 2018;01 Jan 1970;Administrator;Administrator;Dokumen disetujui;Administrator;Dokumen disetujui;Administrator;Dokumen disetujui;Administrator|', 1, '2018-02-19 03:12:18');
INSERT INTO `trx_tasks_statuses` VALUES (50, 8, 689, 881, 'proses-surat-keluar', 2, '|date=2018-02-19|sender=Kepala Pusdiklat Tenaga Administrasi|receiver=Kementerian Dalam Negeri Republik Indonesia|result=2;00058/040-PDM/II/2018;2018-02-19;2018-02-19;1;4;-;00058;Kepala Pusdiklat Tenaga Administrasi;Kementerian Dalam Negeri Republik Indonesia;Undangan Rapat;Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.;1;2018-02-19;OKE;APPROVED;1;2018-02-19;OKE;APPROVED;1;2018-02-19;OKE;APPROVED;1;2018-02-19;Bagian Umum;19 Feb 2018;19 Feb 2018;Perpustakaan / Dokumen / Kearsipan / Sandi;040 - Perpustakaan / Dokumen / Kearsipan / Sandi;19 Feb 2018;19 Feb 2018;19 Feb 2018;19 Feb 2018;01 Jan 1970;Administrator;Administrator;Dokumen disetujui;Administrator;Dokumen disetujui;Administrator;Dokumen disetujui;Administrator|', 1, '2018-02-19 03:16:39');
INSERT INTO `trx_tasks_statuses` VALUES (51, 8, 690, 882, 'proses-surat-keluar', 2, '|date=2018-02-19|sender=Kepala Pusdiklat Tenaga Administrasi|receiver=Kementerian Dalam Negeri Republik Indonesia|result=2;00058/040-PDM/II/2018;2018-02-19;2018-02-19;1;4;-;00058;Kepala Pusdiklat Tenaga Administrasi;Kementerian Dalam Negeri Republik Indonesia;Undangan Rapat;Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.;1;2018-02-19;OKE;APPROVED;1;2018-02-19;OKE;APPROVED;1;2018-02-19;OKE;APPROVED;1;2018-02-19;2018-02-19;Dikirim dengan JNE;Bagian Umum;19 Feb 2018;19 Feb 2018;Perpustakaan / Dokumen / Kearsipan / Sandi;040 - Perpustakaan / Dokumen / Kearsipan / Sandi;19 Feb 2018;19 Feb 2018;19 Feb 2018;19 Feb 2018;19 Feb 2018;Administrator;Administrator;Dokumen disetujui;Administrator;Dokumen disetujui;Administrator;Dokumen disetujui;Administrator|', 1, '2018-02-19 03:18:17');
INSERT INTO `trx_tasks_statuses` VALUES (52, 8, 707, 894, 'proses-surat-keluar', 2, '|date=2018-02-19|sender=Kepala Pusdiklat Tenaga Administrasi|receiver=Kementerian Dalam Negeri Republik Indonesia|result=2;00058/040-PDM/II/2018;2018-02-19;2018-02-19;1;4;-;00058;Kepala Pusdiklat Tenaga Administrasi;Kementerian Dalam Negeri Republik Indonesia;Undangan Rapat;Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.;1;2018-02-19;OKE;APPROVED;1;2018-02-19;OKE;APPROVED;1;2018-02-19;OKE;APPROVED;1;2018-02-19;2018-02-19;Dikirim dengan JNE;DONE;Bagian Umum;19 Feb 2018;19 Feb 2018;Perpustakaan / Dokumen / Kearsipan / Sandi;040 - Perpustakaan / Dokumen / Kearsipan / Sandi;19 Feb 2018;19 Feb 2018;19 Feb 2018;19 Feb 2018;19 Feb 2018;Administrator;Administrator;Dokumen disetujui;Administrator;Dokumen disetujui;Administrator;Dokumen disetujui;Administrator|', 0, '2018-02-19 03:19:47');

-- ----------------------------
-- Table structure for trx_tasks_users
-- ----------------------------
DROP TABLE IF EXISTS `trx_tasks_users`;
CREATE TABLE `trx_tasks_users`  (
  `ttu_tt_id` bigint(20) NULL DEFAULT NULL,
  `ttu_su_id` bigint(20) NULL DEFAULT NULL,
  `ttu_id` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ttu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;
