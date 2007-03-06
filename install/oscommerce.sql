# $Id$
#
# osCommerce, Open Source E-Commerce Solutions
# http://www.oscommerce.com
#
# Copyright (c) 2007 osCommerce
#
# Released under the GNU General Public License
#
# NOTE: * Please make any modifications to this file by hand!
#       * DO NOT use a mysqldump created file for new changes!
#       * Please take note of the table structure, and use this
#         structure as a standard for future modifications!
#       * Any tables you add here should be added in admin/backup.php
#         and in catalog/install/includes/functions/database.php
#       * To see the 'diff'erence between MySQL databases, use
#         the mysqldiff perl script located in the extras
#         directory of the 'catalog' module.
#       * Comments should be like these, full line comments.
#         (don't use inline comments)

DROP TABLE IF EXISTS osc_address_book;
CREATE TABLE osc_address_book (
   address_book_id int NOT NULL auto_increment,
   customers_id int NOT NULL,
   entry_gender char(1) NOT NULL,
   entry_company varchar(32),
   entry_firstname varchar(32) NOT NULL,
   entry_lastname varchar(32) NOT NULL,
   entry_street_address varchar(64) NOT NULL,
   entry_suburb varchar(32),
   entry_postcode varchar(10) NOT NULL,
   entry_city varchar(32) NOT NULL,
   entry_state varchar(32),
   entry_country_id int DEFAULT '0' NOT NULL,
   entry_zone_id int DEFAULT '0' NOT NULL,
   entry_telephone varchar(32),
   entry_fax varchar(32),
   PRIMARY KEY (address_book_id),
   KEY idx_address_book_customers_id (customers_id)
);

DROP TABLE IF EXISTS osc_administrators;
CREATE TABLE osc_administrators (
  id int NOT NULL auto_increment,
  user_name varchar(32) binary NOT NULL,
  user_password varchar(40) NOT NULL,
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS osc_administrators_access;
CREATE TABLE osc_administrators_access (
  administrators_id int NOT NULL,
  module varchar(255) NOT NULL,
  PRIMARY KEY (administrators_id, module)
);

DROP TABLE IF EXISTS osc_administrators_log;
CREATE TABLE osc_administrators_log (
  id int NOT NULL,
  module varchar(255) NOT NULL,
  module_action varchar(32),
  module_id int,
  field_key varchar(255) NOT NULL,
  old_value text,
  new_value text,
  action varchar(255) NOT NULL,
  administrators_id int NOT NULL,
  datestamp datetime NOT NULL,
  KEY idx_administrators_log_id (id)
);

DROP TABLE IF EXISTS osc_banners;
CREATE TABLE osc_banners (
  banners_id int NOT NULL auto_increment,
  banners_title varchar(64) NOT NULL,
  banners_url varchar(255) NOT NULL,
  banners_image varchar(64) NOT NULL,
  banners_group varchar(10) NOT NULL,
  banners_html_text text,
  expires_impressions int(7) DEFAULT '0',
  expires_date datetime DEFAULT NULL,
  date_scheduled datetime DEFAULT NULL,
  date_added datetime NOT NULL,
  date_status_change datetime DEFAULT NULL,
  status int(1) DEFAULT '1' NOT NULL,
  PRIMARY KEY  (banners_id)
);

DROP TABLE IF EXISTS osc_banners_history;
CREATE TABLE osc_banners_history (
  banners_history_id int NOT NULL auto_increment,
  banners_id int NOT NULL,
  banners_shown int(5) NOT NULL DEFAULT '0',
  banners_clicked int(5) NOT NULL DEFAULT '0',
  banners_history_date datetime NOT NULL,
  PRIMARY KEY  (banners_history_id)
);

DROP TABLE IF EXISTS osc_categories;
CREATE TABLE osc_categories (
   categories_id int NOT NULL auto_increment,
   categories_image varchar(64),
   parent_id int DEFAULT '0' NOT NULL,
   sort_order int(3),
   date_added datetime,
   last_modified datetime,
   PRIMARY KEY (categories_id),
   KEY idx_categories_parent_id (parent_id)
);

DROP TABLE IF EXISTS osc_categories_description;
CREATE TABLE osc_categories_description (
   categories_id int DEFAULT '0' NOT NULL,
   language_id int DEFAULT '1' NOT NULL,
   categories_name varchar(32) NOT NULL,
   PRIMARY KEY (categories_id, language_id),
   KEY idx_categories_name (categories_name)
);

DROP TABLE IF EXISTS osc_configuration;
CREATE TABLE osc_configuration (
  configuration_id int NOT NULL auto_increment,
  configuration_title varchar(64) NOT NULL,
  configuration_key varchar(64) NOT NULL,
  configuration_value varchar(255) NOT NULL,
  configuration_description varchar(255) NOT NULL,
  configuration_group_id int NOT NULL,
  sort_order int(5) NULL,
  last_modified datetime NULL,
  date_added datetime NOT NULL,
  use_function varchar(255) NULL,
  set_function varchar(255) NULL,
  PRIMARY KEY (configuration_id)
);

DROP TABLE IF EXISTS osc_configuration_group;
CREATE TABLE osc_configuration_group (
  configuration_group_id int NOT NULL auto_increment,
  configuration_group_title varchar(64) NOT NULL,
  configuration_group_description varchar(255) NOT NULL,
  sort_order int(5) NULL,
  visible int(1) DEFAULT '1' NULL,
  PRIMARY KEY (configuration_group_id)
);

DROP TABLE IF EXISTS osc_counter;
CREATE TABLE osc_counter (
  startdate datetime,
  counter int
);

DROP TABLE IF EXISTS osc_countries;
CREATE TABLE osc_countries (
  countries_id int NOT NULL auto_increment,
  countries_name varchar(64) NOT NULL,
  countries_iso_code_2 char(2) NOT NULL,
  countries_iso_code_3 char(3) NOT NULL,
  address_format varchar(255) NULL,
  PRIMARY KEY (countries_id),
  KEY IDX_COUNTRIES_NAME (countries_name)
);

DROP TABLE IF EXISTS osc_credit_cards;
CREATE TABLE osc_credit_cards (
  id int NOT NULL auto_increment,
  credit_card_name varchar(32) NOT NULL,
  pattern varchar(64) NOT NULL,
  credit_card_status char(1) NOT NULL,
  sort_order int default '0',
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS osc_currencies;
CREATE TABLE osc_currencies (
  currencies_id int NOT NULL auto_increment,
  title varchar(32) NOT NULL,
  code char(3) NOT NULL,
  symbol_left varchar(12),
  symbol_right varchar(12),
  decimal_places char(1),
  value float(13,8),
  last_updated datetime NULL,
  PRIMARY KEY (currencies_id)
);

DROP TABLE IF EXISTS osc_customers;
CREATE TABLE osc_customers (
  customers_id int NOT NULL auto_increment,
  customers_gender char(1),
  customers_firstname varchar(32) NOT NULL,
  customers_lastname varchar(32) NOT NULL,
  customers_dob datetime,
  customers_email_address varchar(96) NOT NULL,
  customers_default_address_id int,
  customers_telephone varchar(32),
  customers_fax varchar(32),
  customers_password varchar(40),
  customers_newsletter char(1),
  customers_status int(1) DEFAULT '0',
  customers_ip_address varchar(15),
  date_last_logon datetime,
  number_of_logons int(5),
  date_account_created datetime,
  date_account_last_modified datetime,
  global_product_notifications int(1) DEFAULT '0',
  PRIMARY KEY (customers_id)
);

DROP TABLE IF EXISTS osc_customers_basket;
CREATE TABLE osc_customers_basket (
  customers_basket_id int NOT NULL auto_increment,
  customers_id int NOT NULL,
  products_id tinytext NOT NULL,
  customers_basket_quantity int NOT NULL,
  final_price decimal(15,4) NOT NULL,
  customers_basket_date_added datetime,
  PRIMARY KEY (customers_basket_id)
);

DROP TABLE IF EXISTS osc_languages;
CREATE TABLE osc_languages (
  languages_id int NOT NULL auto_increment,
  name varchar(32)  NOT NULL,
  code char(5) NOT NULL,
  locale varchar(255) NOT NULL,
  charset varchar(32) NOT NULL,
  date_format_short varchar(32) NOT NULL,
  date_format_long varchar(32) NOT NULL,
  time_format varchar(32) NOT NULL,
  text_direction varchar(12) NOT NULL,
  currencies_id int NOT NULL,
  numeric_separator_decimal varchar(12) NOT NULL,
  numeric_separator_thousands varchar(12) NOT NULL,
  sort_order int(3),
  PRIMARY KEY (languages_id)
);

DROP TABLE IF EXISTS osc_languages_definitions;
CREATE TABLE osc_languages_definitions (
  id int NOT NULL auto_increment,
  languages_id int NOT NULL,
  content_group varchar(32) NOT NULL,
  definition_key varchar(255) NOT NULL,
  definition_value text NOT NULL,
  PRIMARY KEY (id),
  KEY IDX_LANGUAGES_DEFINITIONS_LANGUAGES (languages_id),
  KEY IDX_LANGUAGES_DEFINITIONS (languages_id, content_group),
  KEY IDX_LANGUAGES_DEFINITIONS_GROUPS (content_group)
);

DROP TABLE IF EXISTS osc_manufacturers;
CREATE TABLE osc_manufacturers (
  manufacturers_id int NOT NULL auto_increment,
  manufacturers_name varchar(32) NOT NULL,
  manufacturers_image varchar(64),
  date_added datetime NULL,
  last_modified datetime NULL,
  PRIMARY KEY (manufacturers_id),
  KEY IDX_MANUFACTURERS_NAME (manufacturers_name)
);

DROP TABLE IF EXISTS osc_manufacturers_info;
CREATE TABLE osc_manufacturers_info (
  manufacturers_id int NOT NULL,
  languages_id int NOT NULL,
  manufacturers_url varchar(255) NOT NULL,
  url_clicked int(5) NOT NULL default '0',
  date_last_click datetime NULL,
  PRIMARY KEY (manufacturers_id, languages_id)
);

DROP TABLE IF EXISTS osc_newsletters;
CREATE TABLE osc_newsletters (
  newsletters_id int NOT NULL auto_increment,
  title varchar(255) NOT NULL,
  content text NOT NULL,
  module varchar(255) NOT NULL,
  date_added datetime NOT NULL,
  date_sent datetime,
  status int(1),
  locked int(1) DEFAULT '0',
  PRIMARY KEY (newsletters_id)
);

DROP TABLE IF EXISTS osc_newsletters_log;
CREATE TABLE osc_newsletters_log (
  newsletters_id int NOT NULL,
  email_address varchar(255) NOT NULL,
  date_sent datetime,
  KEY IDX_NEWSLETTERS_LOG_NEWSLETTERS_ID (newsletters_id),
  KEY IDX_NEWSLETTERS_LOG_EMAIL_ADDRESS (email_address)
);

DROP TABLE IF EXISTS osc_orders;
CREATE TABLE osc_orders (
  orders_id int NOT NULL auto_increment,
  customers_id int NOT NULL,
  customers_name varchar(64) NOT NULL,
  customers_company varchar(32),
  customers_street_address varchar(64) NOT NULL,
  customers_suburb varchar(32),
  customers_city varchar(32) NOT NULL,
  customers_postcode varchar(10) NOT NULL,
  customers_state varchar(32),
  customers_state_code varchar(32),
  customers_country varchar(64) NOT NULL,
  customers_country_iso2 char(2) NOT NULL,
  customers_country_iso3 char(3) NOT NULL,
  customers_telephone varchar(32) NOT NULL,
  customers_email_address varchar(96) NOT NULL,
  customers_address_format varchar(255) NOT NULL,
  customers_ip_address varchar(15),
  delivery_name varchar(64) NOT NULL,
  delivery_company varchar(32),
  delivery_street_address varchar(64) NOT NULL,
  delivery_suburb varchar(32),
  delivery_city varchar(32) NOT NULL,
  delivery_postcode varchar(10) NOT NULL,
  delivery_state varchar(32),
  delivery_state_code varchar(32),
  delivery_country varchar(64) NOT NULL,
  delivery_country_iso2 char(2) NOT NULL,
  delivery_country_iso3 char(3) NOT NULL,
  delivery_address_format varchar(255) NOT NULL,
  billing_name varchar(64) NOT NULL,
  billing_company varchar(32),
  billing_street_address varchar(64) NOT NULL,
  billing_suburb varchar(32),
  billing_city varchar(32) NOT NULL,
  billing_postcode varchar(10) NOT NULL,
  billing_state varchar(32),
  billing_state_code varchar(32),
  billing_country varchar(64) NOT NULL,
  billing_country_iso2 char(2) NOT NULL,
  billing_country_iso3 char(3) NOT NULL,
  billing_address_format varchar(255) NOT NULL,
  payment_method varchar(255) NOT NULL,
  payment_module varchar(255) NOT NULL,
  last_modified datetime,
  date_purchased datetime,
  orders_status int(5) NOT NULL,
  orders_date_finished datetime,
  currency char(3),
  currency_value decimal(14,6),
  PRIMARY KEY (orders_id)
);

DROP TABLE IF EXISTS osc_orders_products;
CREATE TABLE osc_orders_products (
  orders_products_id int NOT NULL auto_increment,
  orders_id int NOT NULL,
  products_id int NOT NULL,
  products_model varchar(12),
  products_name varchar(64) NOT NULL,
  products_price decimal(15,4) NOT NULL,
  final_price decimal(15,4) NOT NULL,
  products_tax decimal(7,4) NOT NULL,
  products_quantity int(2) NOT NULL,
  PRIMARY KEY (orders_products_id)
);

DROP TABLE IF EXISTS osc_orders_status;
CREATE TABLE osc_orders_status (
   orders_status_id int DEFAULT '0' NOT NULL,
   language_id int DEFAULT '1' NOT NULL,
   orders_status_name varchar(32) NOT NULL,
   PRIMARY KEY (orders_status_id, language_id),
   KEY idx_orders_status_name (orders_status_name)
);

DROP TABLE IF EXISTS osc_orders_status_history;
CREATE TABLE osc_orders_status_history (
   orders_status_history_id int NOT NULL auto_increment,
   orders_id int NOT NULL,
   orders_status_id int(5) NOT NULL,
   date_added datetime NOT NULL,
   customer_notified int(1) DEFAULT '0',
   comments text,
   PRIMARY KEY (orders_status_history_id)
);

DROP TABLE IF EXISTS osc_orders_products_attributes;
CREATE TABLE osc_orders_products_attributes (
  orders_products_attributes_id int NOT NULL auto_increment,
  orders_id int NOT NULL,
  orders_products_id int NOT NULL,
  products_options varchar(32) NOT NULL,
  products_options_values varchar(32) NOT NULL,
  options_values_price decimal(15,4) NOT NULL,
  price_prefix char(1) NOT NULL,
  PRIMARY KEY (orders_products_attributes_id)
);

DROP TABLE IF EXISTS osc_orders_products_download;
CREATE TABLE osc_orders_products_download (
  orders_products_download_id int NOT NULL auto_increment,
  orders_id int NOT NULL default '0',
  orders_products_id int NOT NULL default '0',
  orders_products_filename varchar(255) NOT NULL default '',
  download_maxdays int(2) NOT NULL default '0',
  download_count int(2) NOT NULL default '0',
  PRIMARY KEY  (orders_products_download_id)
);

DROP TABLE IF EXISTS osc_orders_total;
CREATE TABLE osc_orders_total (
  orders_total_id int unsigned NOT NULL auto_increment,
  orders_id int NOT NULL,
  title varchar(255) NOT NULL,
  text varchar(255) NOT NULL,
  value decimal(15,4) NOT NULL,
  class varchar(32) NOT NULL,
  sort_order int NOT NULL,
  PRIMARY KEY (orders_total_id),
  KEY idx_orders_total_orders_id (orders_id)
);

DROP TABLE IF EXISTS osc_orders_transactions_history;
CREATE TABLE osc_orders_transactions_history (
  id int unsigned not null auto_increment,
  orders_id int unsigned not null,
  transaction_code int not null,
  transaction_return_value text not null,
  transaction_return_status int not null,
  date_added datetime,
  PRIMARY KEY (id),
  KEY idx_orders_transactions_history_orders_id (orders_id)
);

DROP TABLE IF EXISTS osc_orders_transactions_status;
CREATE TABLE osc_orders_transactions_status (
   id int unsigned NOT NULL,
   language_id int unsigned NOT NULL,
   status_name varchar(32) NOT NULL,
   PRIMARY KEY (id, language_id),
   KEY idx_orders_transactions_status_name (status_name)
);

DROP TABLE IF EXISTS osc_products;
CREATE TABLE osc_products (
  products_id int NOT NULL auto_increment,
  products_quantity int(4) NOT NULL,
  products_price decimal(15,4) NOT NULL,
  products_date_added datetime NOT NULL,
  products_last_modified datetime,
  products_date_available datetime,
  products_weight decimal(5,2) NOT NULL,
  products_weight_class int NOT NULL,
  products_status tinyint(1) NOT NULL,
  products_tax_class_id int NOT NULL,
  manufacturers_id int NULL,
  products_ordered int NOT NULL default '0',
  PRIMARY KEY (products_id),
  KEY idx_products_date_added (products_date_added)
);

DROP TABLE IF EXISTS osc_products_attributes;
CREATE TABLE osc_products_attributes (
  products_attributes_id int NOT NULL auto_increment,
  products_id int NOT NULL,
  options_id int NOT NULL,
  options_values_id int NOT NULL,
  options_values_price decimal(15,4) NOT NULL,
  price_prefix char(1) NOT NULL,
  PRIMARY KEY (products_attributes_id)
);

DROP TABLE IF EXISTS osc_products_attributes_download;
CREATE TABLE osc_products_attributes_download (
  products_attributes_id int NOT NULL,
  products_attributes_filename varchar(255) NOT NULL default '',
  products_attributes_maxdays int(2) default '0',
  products_attributes_maxcount int(2) default '0',
  PRIMARY KEY  (products_attributes_id)
);

DROP TABLE IF EXISTS osc_products_description;
CREATE TABLE osc_products_description (
  products_id int NOT NULL auto_increment,
  language_id int NOT NULL default '1',
  products_name varchar(64) NOT NULL default '',
  products_description text,
  products_model varchar(16),
  products_keyword varchar(64),
  products_tags varchar(255),
  products_url varchar(255),
  products_viewed int(5) default '0',
  PRIMARY KEY  (products_id,language_id),
  KEY products_name (products_name),
  KEY products_description_keyword (products_keyword)
);

DROP TABLE IF EXISTS osc_products_images;
CREATE TABLE osc_products_images (
  id int NOT NULL auto_increment,
  products_id int NOT NULL,
  image varchar(255) NOT NULL,
  default_flag tinyint(1) NOT NULL,
  sort_order int NOT NULL,
  date_added datetime NOT NULL,
  PRIMARY KEY (id),
  KEY products_images_products_id (products_id)
);

DROP TABLE IF EXISTS osc_products_images_groups;
CREATE TABLE osc_products_images_groups (
  id int NOT NULL,
  language_id int NOT NULL,
  title varchar(255) not null,
  code varchar(32) not null,
  size_width int,
  size_height int,
  force_size tinyint(1) default 0,
  PRIMARY KEY (id, language_id)
);

DROP TABLE IF EXISTS osc_products_notifications;
CREATE TABLE osc_products_notifications (
  products_id int NOT NULL,
  customers_id int NOT NULL,
  date_added datetime NOT NULL,
  PRIMARY KEY (products_id, customers_id)
);

DROP TABLE IF EXISTS osc_products_options;
CREATE TABLE osc_products_options (
  products_options_id int NOT NULL default '0',
  language_id int NOT NULL default '1',
  products_options_name varchar(32) NOT NULL default '',
  PRIMARY KEY  (products_options_id,language_id)
);

DROP TABLE IF EXISTS osc_products_options_values;
CREATE TABLE osc_products_options_values (
  products_options_values_id int NOT NULL default '0',
  language_id int NOT NULL default '1',
  products_options_values_name varchar(64) NOT NULL default '',
  PRIMARY KEY  (products_options_values_id,language_id)
);

DROP TABLE IF EXISTS osc_products_options_values_to_products_options;
CREATE TABLE osc_products_options_values_to_products_options (
  products_options_values_to_products_options_id int NOT NULL auto_increment,
  products_options_id int NOT NULL,
  products_options_values_id int NOT NULL,
  PRIMARY KEY (products_options_values_to_products_options_id)
);

DROP TABLE IF EXISTS osc_products_to_categories;
CREATE TABLE osc_products_to_categories (
  products_id int NOT NULL,
  categories_id int NOT NULL,
  PRIMARY KEY (products_id,categories_id)
);

DROP TABLE IF EXISTS osc_reviews;
CREATE TABLE osc_reviews (
  reviews_id int NOT NULL auto_increment,
  products_id int NOT NULL,
  customers_id int,
  customers_name varchar(64) NOT NULL,
  reviews_rating int(1),
  languages_id int NOT NULL,
  reviews_text text NOT NULL,
  date_added datetime,
  last_modified datetime,
  reviews_read int(5) NOT NULL default '0',
  reviews_status tinyint(1) NOT NULL,
  PRIMARY KEY (reviews_id)
);

DROP TABLE IF EXISTS osc_sessions;
CREATE TABLE osc_sessions (
  sesskey varchar(32) NOT NULL,
  expiry int(11) unsigned NOT NULL,
  value text NOT NULL,
  PRIMARY KEY (sesskey)
);

DROP TABLE IF EXISTS osc_specials;
CREATE TABLE osc_specials (
  specials_id int NOT NULL auto_increment,
  products_id int NOT NULL,
  specials_new_products_price decimal(15,4) NOT NULL,
  specials_date_added datetime,
  specials_last_modified datetime,
  start_date datetime,
  expires_date datetime,
  date_status_change datetime,
  status int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (specials_id)
);

DROP TABLE IF EXISTS osc_tax_class;
CREATE TABLE osc_tax_class (
  tax_class_id int NOT NULL auto_increment,
  tax_class_title varchar(32) NOT NULL,
  tax_class_description varchar(255) NOT NULL,
  last_modified datetime NULL,
  date_added datetime NOT NULL,
  PRIMARY KEY (tax_class_id)
);

DROP TABLE IF EXISTS osc_tax_rates;
CREATE TABLE osc_tax_rates (
  tax_rates_id int NOT NULL auto_increment,
  tax_zone_id int NOT NULL,
  tax_class_id int NOT NULL,
  tax_priority int(5) DEFAULT 1,
  tax_rate decimal(7,4) NOT NULL,
  tax_description varchar(255) NOT NULL,
  last_modified datetime NULL,
  date_added datetime NOT NULL,
  PRIMARY KEY (tax_rates_id)
);

DROP TABLE IF EXISTS osc_geo_zones;
CREATE TABLE osc_geo_zones (
  geo_zone_id int NOT NULL auto_increment,
  geo_zone_name varchar(32) NOT NULL,
  geo_zone_description varchar(255) NOT NULL,
  last_modified datetime NULL,
  date_added datetime NOT NULL,
  PRIMARY KEY (geo_zone_id)
);

DROP TABLE IF EXISTS osc_templates;
CREATE TABLE osc_templates (
  id int NOT NULL auto_increment,
  title varchar(64) not null,
  code varchar(32) not null,
  author_name varchar(64) not null,
  author_www varchar(255),
  markup_version varchar(32),
  css_based tinyint,
  medium varchar(32),
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS osc_templates_boxes;
CREATE TABLE osc_templates_boxes (
  id int NOT NULL auto_increment,
  title varchar(64) not null,
  code varchar(32) not null,
  author_name varchar(64) not null,
  author_www varchar(255),
  modules_group varchar(32) not null,
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS osc_templates_boxes_to_pages;
CREATE TABLE osc_templates_boxes_to_pages (
  id int NOT NULL auto_increment,
  templates_boxes_id int not null,
  templates_id int not null,
  content_page varchar(255) not null,
  boxes_group varchar(32) not null,
  sort_order int default 0,
  page_specific int default 0,
  PRIMARY KEY (id),
  INDEX (templates_boxes_id, templates_id, content_page, boxes_group)
);

DROP TABLE IF EXISTS osc_weight_classes;
CREATE TABLE osc_weight_classes (
  weight_class_id int NOT NULL default '0',
  weight_class_key varchar(4) NOT NULL default '',
  language_id int NOT NULL default '0',
  weight_class_title varchar(32) NOT NULL default '',
  PRIMARY KEY (weight_class_id, language_id)
);

DROP TABLE IF EXISTS osc_weight_classes_rules;
CREATE TABLE osc_weight_classes_rules (
  weight_class_from_id int(11) NOT NULL default '0',
  weight_class_to_id int(11) NOT NULL default '0',
  weight_class_rule decimal(15,4) NOT NULL default '0.0000'
);
DROP TABLE IF EXISTS osc_whos_online;
CREATE TABLE osc_whos_online (
  customer_id int,
  full_name varchar(64) NOT NULL,
  session_id varchar(128) NOT NULL,
  ip_address varchar(15) NOT NULL,
  time_entry varchar(14) NOT NULL,
  time_last_click varchar(14) NOT NULL,
  last_page_url varchar(255) NOT NULL
);

DROP TABLE IF EXISTS osc_zones;
CREATE TABLE osc_zones (
  zone_id int NOT NULL auto_increment,
  zone_country_id int NOT NULL,
  zone_code varchar(32) NOT NULL,
  zone_name varchar(64) NOT NULL,
  PRIMARY KEY (zone_id)
);

DROP TABLE IF EXISTS osc_zones_to_geo_zones;
CREATE TABLE osc_zones_to_geo_zones (
   association_id int NOT NULL auto_increment,
   zone_country_id int NOT NULL,
   zone_id int NULL,
   geo_zone_id int NULL,
   last_modified datetime NULL,
   date_added datetime NOT NULL,
   PRIMARY KEY (association_id)
);

INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Store Name', 'STORE_NAME', 'osCommerce', 'The name of my store', '1', '1', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Store Owner', 'STORE_OWNER', 'Store Owner', 'The name of my store owner', '1', '2', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('E-Mail Address', 'STORE_OWNER_EMAIL_ADDRESS', 'root@localhost', 'The e-mail address of my store owner', '1', '3', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('E-Mail From', 'EMAIL_FROM', '"Store Owner" <root@localhost>', 'The e-mail address used in (sent) e-mails', '1', '4', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Country', 'STORE_COUNTRY', '223', 'The country my store is located in <br><br><b>Note: Please remember to update the store zone.</b>', '1', '6', 'osC_Address::getCountryName', 'osc_cfg_set_countries_pulldown_menu', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Zone', 'STORE_ZONE', '176', 'The zone my store is located in', '1', '7', 'osC_Address::getZoneName', 'osc_cfg_set_zones_pulldown_menu', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Send Extra Order Emails To', 'SEND_EXTRA_ORDER_EMAILS_TO', '', 'Send extra order emails to the following email addresses, in this format: Name 1 &lt;email@address1&gt;, Name 2 &lt;email@address2&gt;', '1', '11', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Allow Guest To Tell A Friend', 'ALLOW_GUEST_TO_TELL_A_FRIEND', '-1', 'Allow guests to tell a friend about a product', '1', '15', 'osc_cfg_use_get_boolean_value', 'osc_cfg_set_boolean_value(array(1, -1))', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Store Address and Phone', 'STORE_NAME_ADDRESS', 'Store Name\nAddress\nCountry\nPhone', 'This is the Store Name, Address and Phone used on printable documents and displayed online', '1', '18', 'osc_cfg_set_textarea_field', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Tax Decimal Places', 'TAX_DECIMAL_PLACES', '0', 'Pad the tax value this amount of decimal places', '1', '20', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Display Prices with Tax', 'DISPLAY_PRICE_WITH_TAX', '-1', 'Display prices with tax included (true) or add the tax at the end (false)', '1', '21', 'osc_cfg_use_get_boolean_value', 'osc_cfg_set_boolean_value(array(1, -1))', now());

INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Credit Card Owner Name', 'CC_OWNER_MIN_LENGTH', '3', 'Minimum length of credit card owner name', '2', '12', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Credit Card Number', 'CC_NUMBER_MIN_LENGTH', '10', 'Minimum length of credit card number', '2', '13', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Review Text', 'REVIEW_TEXT_MIN_LENGTH', '50', 'Minimum length of review text', '2', '14', now());

INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Address Book Entries', 'MAX_ADDRESS_BOOK_ENTRIES', '5', 'Maximum address book entries a customer is allowed to have', '3', '1', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Search Results', 'MAX_DISPLAY_SEARCH_RESULTS', '20', 'Amount of products to list', '3', '2', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Page Links', 'MAX_DISPLAY_PAGE_LINKS', '5', 'Number of \'number\' links use for page-sets', '3', '3', now());

INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Categories To List Per Row', 'MAX_DISPLAY_CATEGORIES_PER_ROW', '3', 'How many categories to list per row', '3', '13', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('New Products Listing', 'MAX_DISPLAY_PRODUCTS_NEW', '10', 'Maximum number of new products to display in new products page', '3', '14', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Order History', 'MAX_DISPLAY_ORDER_HISTORY', '10', 'Maximum number of orders to display in the order history page', '3', '18', now());

INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Heading Image Width', 'HEADING_IMAGE_WIDTH', '57', 'The pixel width of heading images', '4', '3', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Heading Image Height', 'HEADING_IMAGE_HEIGHT', '40', 'The pixel height of heading images', '4', '4', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Image Required', 'IMAGE_REQUIRED', '1', 'Enable to display broken images. Good for development.', '4', '8', 'osc_cfg_use_get_boolean_value', 'osc_cfg_set_boolean_value(array(1, -1))', now());

INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Gender', 'ACCOUNT_GENDER', '1', 'Ask for or require the customers gender.', '5', '10', 'osc_cfg_use_get_boolean_value', 'osc_cfg_set_boolean_value(array(1, 0, -1))', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('First Name', 'ACCOUNT_FIRST_NAME', '2', 'Minimum requirement for the customers first name.', '5', '11', 'osc_cfg_set_boolean_value(array(\'1\', \'2\', \'3\', \'4\', \'5\', \'6\', \'7\', \'8\', \'9\', \'10\'))', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Last Name', 'ACCOUNT_LAST_NAME', '2', 'Minimum requirement for the customers last name.', '5', '12', 'osc_cfg_set_boolean_value(array(\'1\', \'2\', \'3\', \'4\', \'5\', \'6\', \'7\', \'8\', \'9\', \'10\'))', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Date Of Birth', 'ACCOUNT_DATE_OF_BIRTH', '1', 'Ask for the customers date of birth.', '5', '13', 'osc_cfg_use_get_boolean_value', 'osc_cfg_set_boolean_value(array(1, -1))', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('E-Mail Address', 'ACCOUNT_EMAIL_ADDRESS', '6', 'Minimum requirement for the customers e-mail address.', '5', '14', 'osc_cfg_set_boolean_value(array(\'1\', \'2\', \'3\', \'4\', \'5\', \'6\', \'7\', \'8\', \'9\', \'10\'))', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Password', 'ACCOUNT_PASSWORD', '5', 'Minimum requirement for the customers password.', '5', '15', 'osc_cfg_set_boolean_value(array(\'1\', \'2\', \'3\', \'4\', \'5\', \'6\', \'7\', \'8\', \'9\', \'10\'))', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Newsletter', 'ACCOUNT_NEWSLETTER', '1', 'Ask for a newsletter subscription.', '5', '16', 'osc_cfg_use_get_boolean_value', 'osc_cfg_set_boolean_value(array(1, -1))', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Company Name', 'ACCOUNT_COMPANY', '0', 'Ask for or require the customers company name.', '5', '17', 'osc_cfg_use_get_boolean_value', 'osc_cfg_set_boolean_value(array(\'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\', 0, -1))', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Street Address', 'ACCOUNT_STREET_ADDRESS', '5', 'Minimum requirement for the customers street address.', '5', '18', 'osc_cfg_set_boolean_value(array(\'1\', \'2\', \'3\', \'4\', \'5\', \'6\', \'7\', \'8\', \'9\', \'10\'))', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Suburb', 'ACCOUNT_SUBURB', '0', 'Ask for or require the customers suburb.', '5', '19', 'osc_cfg_use_get_boolean_value', 'osc_cfg_set_boolean_value(array(\'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\', 0, -1))', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Post Code', 'ACCOUNT_POST_CODE', '0', 'Minimum requirement for the customers post code.', '5', '20', 'osc_cfg_use_get_boolean_value', 'osc_cfg_set_boolean_value(array(-1, 0, \'1\', \'2\', \'3\', \'4\', \'5\', \'6\', \'7\', \'8\', \'9\', \'10\'))', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('City', 'ACCOUNT_CITY', '4', 'Minimum requirement for the customers city.', '5', '21', 'osc_cfg_set_boolean_value(array(\'1\', \'2\', \'3\', \'4\', \'5\', \'6\', \'7\', \'8\', \'9\', \'10\'))', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('State', 'ACCOUNT_STATE', '2', 'Ask for or require the customers state.', '5', '22', 'osc_cfg_use_get_boolean_value', 'osc_cfg_set_boolean_value(array(\'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\', 0, -1))', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Country', 'ACCOUNT_COUNTRY', '1', 'Ask for the customers country.', '5', '23', 'osc_cfg_use_get_boolean_value', 'osc_cfg_set_boolean_value(array(1))', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Telephone Number', 'ACCOUNT_TELEPHONE', '3', 'Ask for or require the customers telephone number.', '5', '24', 'osc_cfg_use_get_boolean_value', 'osc_cfg_set_boolean_value(array(\'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\', 0, -1))', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Fax Number', 'ACCOUNT_FAX', '0', 'Ask for or require the customers fax number.', '5', '25', 'osc_cfg_use_get_boolean_value', 'osc_cfg_set_boolean_value(array(\'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\', 0, -1))', now());

INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Default Currency', 'DEFAULT_CURRENCY', 'USD', 'Default Currency', '6', '0', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Default Language', 'DEFAULT_LANGUAGE', 'en_US', 'Default Language', '6', '0', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Default Order Status For New Orders', 'DEFAULT_ORDERS_STATUS_ID', '1', 'When a new order is created, this order status will be assigned to it.', '6', '0', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Default Image Group', 'DEFAULT_IMAGE_GROUP_ID', '2', 'Default image group.', '6', '0', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Default Template', 'DEFAULT_TEMPLATE', 'default', 'Default Template', '6', '0', now());

INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Country of Origin', 'SHIPPING_ORIGIN_COUNTRY', '223', 'Select the country of origin to be used in shipping quotes.', '7', '1', 'osC_Address::getCountryName', 'osc_cfg_set_countries_pulldown_menu', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Postal Code', 'SHIPPING_ORIGIN_ZIP', 'NONE', 'Enter the Postal Code (ZIP) of the Store to be used in shipping quotes.', '7', '2', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Enter the Maximum Package Weight you will ship', 'SHIPPING_MAX_WEIGHT', '50', 'Carriers have a max weight limit for a single package. This is a common one for all.', '7', '3', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Package Tare weight.', 'SHIPPING_BOX_WEIGHT', '3', 'What is the weight of typical packaging of small to medium packages?', '7', '4', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Larger packages - percentage increase.', 'SHIPPING_BOX_PADDING', '10', 'For 10% enter 10', '7', '5', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Default Shipping Unit', 'SHIPPING_WEIGHT_UNIT',2, 'Select the unit of weight to be used for shipping.', '7', '6', 'osC_Weight::getTitle', 'osc_cfg_set_weight_classes_pulldown_menu', now());

INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Image', 'PRODUCT_LIST_IMAGE', '1', 'Do you want to display the Product Image?', '8', '1', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Manufaturer Name','PRODUCT_LIST_MANUFACTURER', '0', 'Do you want to display the Product Manufacturer Name?', '8', '2', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Model', 'PRODUCT_LIST_MODEL', '0', 'Do you want to display the Product Model?', '8', '3', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Name', 'PRODUCT_LIST_NAME', '2', 'Do you want to display the Product Name?', '8', '4', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Price', 'PRODUCT_LIST_PRICE', '3', 'Do you want to display the Product Price', '8', '5', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Quantity', 'PRODUCT_LIST_QUANTITY', '0', 'Do you want to display the Product Quantity?', '8', '6', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Weight', 'PRODUCT_LIST_WEIGHT', '0', 'Do you want to display the Product Weight?', '8', '7', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Buy Now column', 'PRODUCT_LIST_BUY_NOW', '4', 'Do you want to display the Buy Now column?', '8', '8', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Category/Manufacturer Filter (0=disable; 1=enable)', 'PRODUCT_LIST_FILTER', '1', 'Do you want to display the Category/Manufacturer Filter?', '8', '9', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Location of Prev/Next Navigation Bar (1-top, 2-bottom, 3-both)', 'PREV_NEXT_BAR_LOCATION', '2', 'Sets the location of the Prev/Next Navigation Bar (1-top, 2-bottom, 3-both)', '8', '10', now());

INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Check stock level', 'STOCK_CHECK', '1', 'Check to see if sufficent stock is available', '9', '1', 'osc_cfg_use_get_boolean_value', 'osc_cfg_set_boolean_value(array(1, -1))', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Subtract stock', 'STOCK_LIMITED', '1', 'Subtract product in stock by product orders', '9', '2', 'osc_cfg_use_get_boolean_value', 'osc_cfg_set_boolean_value(array(1, -1))', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Allow Checkout', 'STOCK_ALLOW_CHECKOUT', '1', 'Allow customer to checkout even if there is insufficient stock', '9', '3', 'osc_cfg_use_get_boolean_value', 'osc_cfg_set_boolean_value(array(1, -1))', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Mark product out of stock', 'STOCK_MARK_PRODUCT_OUT_OF_STOCK', '***', 'Display something on screen so customer can see which product has insufficient stock', '9', '4', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Stock Re-order level', 'STOCK_REORDER_LEVEL', '5', 'Define when stock needs to be re-ordered', '9', '5', now());

INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('E-Mail Transport Method', 'EMAIL_TRANSPORT', 'sendmail', 'Defines if this server uses a local connection to sendmail or uses an SMTP connection via TCP/IP. Servers running on Windows and MacOS should change this setting to SMTP.', '12', '1', 'osc_cfg_set_boolean_value(array(\'sendmail\', \'smtp\'))', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('E-Mail Linefeeds', 'EMAIL_LINEFEED', 'LF', 'Defines the character sequence used to separate mail headers.', '12', '2', 'osc_cfg_set_boolean_value(array(\'LF\', \'CRLF\'))', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Use MIME HTML When Sending Emails', 'EMAIL_USE_HTML', '-1', 'Send e-mails in HTML format', '12', '3', 'osc_cfg_use_get_boolean_value', 'osc_cfg_set_boolean_value(array(1, -1))', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Verify E-Mail Addresses Through DNS', 'ENTRY_EMAIL_ADDRESS_CHECK', '-1', 'Verify e-mail address through a DNS server', '12', '4', 'osc_cfg_use_get_boolean_value', 'osc_cfg_set_boolean_value(array(1, -1))', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Send E-Mails', 'SEND_EMAILS', '1', 'Send out e-mails', '12', '5', 'osc_cfg_use_get_boolean_value', 'osc_cfg_set_boolean_value(array(1, -1))', now());

INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Enable download', 'DOWNLOAD_ENABLED', '-1', 'Enable the products download functions.', '13', '1', 'osc_cfg_use_get_boolean_value', 'osc_cfg_set_boolean_value(array(1, -1))', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Download by redirect', 'DOWNLOAD_BY_REDIRECT', '-1', 'Use browser redirection for download. Disable on non-Unix systems.', '13', '2', 'osc_cfg_use_get_boolean_value', 'osc_cfg_set_boolean_value(array(1, -1))', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Expiry delay (days)' ,'DOWNLOAD_MAX_DAYS', '7', 'Set number of days before the download link expires. 0 means no limit.', '13', '3', '', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Maximum number of downloads' ,'DOWNLOAD_MAX_COUNT', '5', 'Set the maximum number of downloads. 0 means no download authorized.', '13', '4', '', now());

INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Confirm Terms and Conditions During Checkout Procedure', 'DISPLAY_CONDITIONS_ON_CHECKOUT', '-1', 'Show the Terms and Conditions during the checkout procedure which the customer must agree to.', '16', '1', 'osc_cfg_use_get_boolean_value', 'osc_cfg_set_boolean_value(array(1, -1))', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Confirm Privacy Notice During Account Creation Procedure', 'DISPLAY_PRIVACY_CONDITIONS', '-1', 'Show the Privacy Notice during the account creation procedure which the customer must agree to.', '16', '2', 'osc_cfg_use_get_boolean_value', 'osc_cfg_set_boolean_value(array(1, -1))', now());

INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Verify With Regular Expressions', 'CFG_CREDIT_CARDS_VERIFY_WITH_REGEXP', '1', 'Verify credit card numbers with server-side regular expression patterns.', '17', '0', 'osc_cfg_use_get_boolean_value', 'osc_cfg_set_boolean_value(array(1, -1))', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES ('Verify With Javascript', 'CFG_CREDIT_CARDS_VERIFY_WITH_JS', '1', 'Verify credit card numbers with javascript based regular expression patterns.', '17', '1', 'osc_cfg_use_get_boolean_value', 'osc_cfg_set_boolean_value(array(1, -1))', now());

INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('cURL', 'CFG_APP_CURL', '/usr/bin/curl', 'The program location to cURL.', '18', '1', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('ImageMagick "convert"', 'CFG_APP_IMAGEMAGICK_CONVERT', '/usr/bin/convert', 'The program location to ImageMagicks "convert" to use when manipulating images.', '18', '2', now());

INSERT INTO osc_configuration_group VALUES ('1', 'My Store', 'General information about my store', '1', '1');
INSERT INTO osc_configuration_group VALUES ('2', 'Minimum Values', 'The minimum values for functions / data', '2', '1');
INSERT INTO osc_configuration_group VALUES ('3', 'Maximum Values', 'The maximum values for functions / data', '3', '1');
INSERT INTO osc_configuration_group VALUES ('4', 'Images', 'Image parameters', '4', '1');
INSERT INTO osc_configuration_group VALUES ('5', 'Customer Details', 'Customer account configuration', '5', '1');
INSERT INTO osc_configuration_group VALUES ('6', 'Module Options', 'Hidden from configuration', '6', '0');
INSERT INTO osc_configuration_group VALUES ('7', 'Shipping/Packaging', 'Shipping options available at my store', '7', '1');
INSERT INTO osc_configuration_group VALUES ('8', 'Product Listing', 'Product Listing    configuration options', '8', '1');
INSERT INTO osc_configuration_group VALUES ('9', 'Stock', 'Stock configuration options', '9', '1');
INSERT INTO osc_configuration_group VALUES ('12', 'E-Mail Options', 'General setting for E-Mail transport and HTML E-Mails', '12', '1');
INSERT INTO osc_configuration_group VALUES ('13', 'Download', 'Downloadable products options', '13', '1');
INSERT INTO osc_configuration_group VALUES ('16', 'Regulations', 'Regulation options', '16', '1');
INSERT INTO osc_configuration_group VALUES ('17', 'Credit Cards', 'Credit card options', '17', '1');
INSERT INTO osc_configuration_group VALUES ('18', 'Program Locations', 'Locations to certain programs on the server.', '18', '1');

INSERT INTO osc_countries VALUES (1,'Afghanistan','AF','AFG','');
INSERT INTO osc_countries VALUES (2,'Albania','AL','ALB','');
INSERT INTO osc_countries VALUES (3,'Algeria','DZ','DZA','');
INSERT INTO osc_countries VALUES (4,'American Samoa','AS','ASM','');
INSERT INTO osc_countries VALUES (5,'Andorra','AD','AND','');
INSERT INTO osc_countries VALUES (6,'Angola','AO','AGO','');
INSERT INTO osc_countries VALUES (7,'Anguilla','AI','AIA','');
INSERT INTO osc_countries VALUES (8,'Antarctica','AQ','ATA','');
INSERT INTO osc_countries VALUES (9,'Antigua and Barbuda','AG','ATG','');
INSERT INTO osc_countries VALUES (10,'Argentina','AR','ARG',":name\n:street_address\n:postcode :city\n:country");
INSERT INTO osc_countries VALUES (11,'Armenia','AM','ARM','');
INSERT INTO osc_countries VALUES (12,'Aruba','AW','ABW','');
INSERT INTO osc_countries VALUES (13,'Australia','AU','AUS',":name\n:street_address\n:suburb :state_code :postcode\n:country");
INSERT INTO osc_countries VALUES (14,'Austria','AT','AUT',":name\n:street_address\nA-:postcode :city\n:country");
INSERT INTO osc_countries VALUES (15,'Azerbaijan','AZ','AZE','');
INSERT INTO osc_countries VALUES (16,'Bahamas','BS','BHS','');
INSERT INTO osc_countries VALUES (17,'Bahrain','BH','BHR','');
INSERT INTO osc_countries VALUES (18,'Bangladesh','BD','BGD','');
INSERT INTO osc_countries VALUES (19,'Barbados','BB','BRB','');
INSERT INTO osc_countries VALUES (20,'Belarus','BY','BLR','');
INSERT INTO osc_countries VALUES (21,'Belgium','BE','BEL',":name\n:street_address\nB-:postcode :city\n:country");
INSERT INTO osc_countries VALUES (22,'Belize','BZ','BLZ','');
INSERT INTO osc_countries VALUES (23,'Benin','BJ','BEN','');
INSERT INTO osc_countries VALUES (24,'Bermuda','BM','BMU','');
INSERT INTO osc_countries VALUES (25,'Bhutan','BT','BTN','');
INSERT INTO osc_countries VALUES (26,'Bolivia','BO','BOL','');
INSERT INTO osc_countries VALUES (27,'Bosnia and Herzegowina','BA','BIH','');
INSERT INTO osc_countries VALUES (28,'Botswana','BW','BWA','');
INSERT INTO osc_countries VALUES (29,'Bouvet Island','BV','BVT','');
INSERT INTO osc_countries VALUES (30,'Brazil','BR','BRA',":name\n:street_address\n:state\n:postcode\n:country");
INSERT INTO osc_countries VALUES (31,'British Indian Ocean Territory','IO','IOT','');
INSERT INTO osc_countries VALUES (32,'Brunei Darussalam','BN','BRN','');
INSERT INTO osc_countries VALUES (33,'Bulgaria','BG','BGR','');
INSERT INTO osc_countries VALUES (34,'Burkina Faso','BF','BFA','');
INSERT INTO osc_countries VALUES (35,'Burundi','BI','BDI','');
INSERT INTO osc_countries VALUES (36,'Cambodia','KH','KHM','');
INSERT INTO osc_countries VALUES (37,'Cameroon','CM','CMR','');
INSERT INTO osc_countries VALUES (38,'Canada','CA','CAN',":name\n:street_address\n:city :state_code :postcode\n:country");
INSERT INTO osc_countries VALUES (39,'Cape Verde','CV','CPV','');
INSERT INTO osc_countries VALUES (40,'Cayman Islands','KY','CYM','');
INSERT INTO osc_countries VALUES (41,'Central African Republic','CF','CAF','');
INSERT INTO osc_countries VALUES (42,'Chad','TD','TCD','');
INSERT INTO osc_countries VALUES (43,'Chile','CL','CHL',":name\n:street_address\n:city\n:country");
INSERT INTO osc_countries VALUES (44,'China','CN','CHN',":name\n:street_address\n:postcode :city\n:country");
INSERT INTO osc_countries VALUES (45,'Christmas Island','CX','CXR','');
INSERT INTO osc_countries VALUES (46,'Cocos (Keeling) Islands','CC','CCK','');
INSERT INTO osc_countries VALUES (47,'Colombia','CO','COL','');
INSERT INTO osc_countries VALUES (48,'Comoros','KM','COM','');
INSERT INTO osc_countries VALUES (49,'Congo','CG','COG','');
INSERT INTO osc_countries VALUES (50,'Cook Islands','CK','COK','');
INSERT INTO osc_countries VALUES (51,'Costa Rica','CR','CRI','');
INSERT INTO osc_countries VALUES (52,'Cote D\'Ivoire','CI','CIV','');
INSERT INTO osc_countries VALUES (53,'Croatia','HR','HRV','');
INSERT INTO osc_countries VALUES (54,'Cuba','CU','CUB','');
INSERT INTO osc_countries VALUES (55,'Cyprus','CY','CYP','');
INSERT INTO osc_countries VALUES (56,'Czech Republic','CZ','CZE','');
INSERT INTO osc_countries VALUES (57,'Denmark','DK','DNK',":name\n:street_address\nDK-:postcode :city\n:country");
INSERT INTO osc_countries VALUES (58,'Djibouti','DJ','DJI','');
INSERT INTO osc_countries VALUES (59,'Dominica','DM','DMA','');
INSERT INTO osc_countries VALUES (60,'Dominican Republic','DO','DOM','');
INSERT INTO osc_countries VALUES (61,'East Timor','TP','TMP','');
INSERT INTO osc_countries VALUES (62,'Ecuador','EC','ECU','');
INSERT INTO osc_countries VALUES (63,'Egypt','EG','EGY','');
INSERT INTO osc_countries VALUES (64,'El Salvador','SV','SLV','');
INSERT INTO osc_countries VALUES (65,'Equatorial Guinea','GQ','GNQ','');
INSERT INTO osc_countries VALUES (66,'Eritrea','ER','ERI','');
INSERT INTO osc_countries VALUES (67,'Estonia','EE','EST','');
INSERT INTO osc_countries VALUES (68,'Ethiopia','ET','ETH','');
INSERT INTO osc_countries VALUES (69,'Falkland Islands (Malvinas)','FK','FLK','');
INSERT INTO osc_countries VALUES (70,'Faroe Islands','FO','FRO','');
INSERT INTO osc_countries VALUES (71,'Fiji','FJ','FJI','');
INSERT INTO osc_countries VALUES (72,'Finland','FI','FIN',":name\n:street_address\nFIN-:postcode :city\n:country");
INSERT INTO osc_countries VALUES (73,'France','FR','FRA',":name\n:street_address\n:postcode :city\n:country");
INSERT INTO osc_countries VALUES (74,'France, Metropolitan','FX','FXX',":name\n:street_address\n:postcode :city\n:country");
INSERT INTO osc_countries VALUES (75,'French Guiana','GF','GUF',":name\n:street_address\n:postcode :city\n:country");
INSERT INTO osc_countries VALUES (76,'French Polynesia','PF','PYF',":name\n:street_address\n:postcode :city\n:country");
INSERT INTO osc_countries VALUES (77,'French Southern Territories','TF','ATF',":name\n:street_address\n:postcode :city\n:country");
INSERT INTO osc_countries VALUES (78,'Gabon','GA','GAB','');
INSERT INTO osc_countries VALUES (79,'Gambia','GM','GMB','');
INSERT INTO osc_countries VALUES (80,'Georgia','GE','GEO','');
INSERT INTO osc_countries VALUES (81,'Germany','DE','DEU',":name\n:street_address\nD-:postcode :city\n:country");
INSERT INTO osc_countries VALUES (82,'Ghana','GH','GHA','');
INSERT INTO osc_countries VALUES (83,'Gibraltar','GI','GIB','');
INSERT INTO osc_countries VALUES (84,'Greece','GR','GRC','');
INSERT INTO osc_countries VALUES (85,'Greenland','GL','GRL',":name\n:street_address\nDK-:postcode :city\n:country");
INSERT INTO osc_countries VALUES (86,'Grenada','GD','GRD','');
INSERT INTO osc_countries VALUES (87,'Guadeloupe','GP','GLP','');
INSERT INTO osc_countries VALUES (88,'Guam','GU','GUM','');
INSERT INTO osc_countries VALUES (89,'Guatemala','GT','GTM','');
INSERT INTO osc_countries VALUES (90,'Guinea','GN','GIN','');
INSERT INTO osc_countries VALUES (91,'Guinea-bissau','GW','GNB','');
INSERT INTO osc_countries VALUES (92,'Guyana','GY','GUY','');
INSERT INTO osc_countries VALUES (93,'Haiti','HT','HTI','');
INSERT INTO osc_countries VALUES (94,'Heard and Mc Donald Islands','HM','HMD','');
INSERT INTO osc_countries VALUES (95,'Honduras','HN','HND','');
INSERT INTO osc_countries VALUES (96,'Hong Kong','HK','HKG',":name\n:street_address\n:city\n:country");
INSERT INTO osc_countries VALUES (97,'Hungary','HU','HUN','');
INSERT INTO osc_countries VALUES (98,'Iceland','IS','ISL',":name\n:street_address\nIS:postcode :city\n:country");
INSERT INTO osc_countries VALUES (99,'India','IN','IND',":name\n:street_address\n:city-:postcode\n:country");
INSERT INTO osc_countries VALUES (100,'Indonesia','ID','IDN',":name\n:street_address\n:city :postcode\n:country");
INSERT INTO osc_countries VALUES (101,'Iran (Islamic Republic of)','IR','IRN','');
INSERT INTO osc_countries VALUES (102,'Iraq','IQ','IRQ','');
INSERT INTO osc_countries VALUES (103,'Ireland','IE','IRL',":name\n:street_address\nIE-:city\n:country");
INSERT INTO osc_countries VALUES (104,'Israel','IL','ISR',":name\n:street_address\n:postcode :city\n:country");
INSERT INTO osc_countries VALUES (105,'Italy','IT','ITA',":name\n:street_address\n:postcode-:city :state_code\n:country");
INSERT INTO osc_countries VALUES (106,'Jamaica','JM','JAM','');
INSERT INTO osc_countries VALUES (107,'Japan','JP','JPN',":name\n:street_address, :suburb\n:city :postcode\n:country");
INSERT INTO osc_countries VALUES (108,'Jordan','JO','JOR','');
INSERT INTO osc_countries VALUES (109,'Kazakhstan','KZ','KAZ','');
INSERT INTO osc_countries VALUES (110,'Kenya','KE','KEN','');
INSERT INTO osc_countries VALUES (111,'Kiribati','KI','KIR','');
INSERT INTO osc_countries VALUES (112,'Korea, Democratic People\'s Republic of','KP','PRK','');
INSERT INTO osc_countries VALUES (113,'Korea, Republic of','KR','KOR','');
INSERT INTO osc_countries VALUES (114,'Kuwait','KW','KWT','');
INSERT INTO osc_countries VALUES (115,'Kyrgyzstan','KG','KGZ','');
INSERT INTO osc_countries VALUES (116,'Lao People\'s Democratic Republic','LA','LAO','');
INSERT INTO osc_countries VALUES (117,'Latvia','LV','LVA','');
INSERT INTO osc_countries VALUES (118,'Lebanon','LB','LBN','');
INSERT INTO osc_countries VALUES (119,'Lesotho','LS','LSO','');
INSERT INTO osc_countries VALUES (120,'Liberia','LR','LBR','');
INSERT INTO osc_countries VALUES (121,'Libyan Arab Jamahiriya','LY','LBY','');
INSERT INTO osc_countries VALUES (122,'Liechtenstein','LI','LIE','');
INSERT INTO osc_countries VALUES (123,'Lithuania','LT','LTU','');
INSERT INTO osc_countries VALUES (124,'Luxembourg','LU','LUX',":name\n:street_address\nL-:postcode :city\n:country");
INSERT INTO osc_countries VALUES (125,'Macau','MO','MAC','');
INSERT INTO osc_countries VALUES (126,'Macedonia, The Former Yugoslav Republic of','MK','MKD','');
INSERT INTO osc_countries VALUES (127,'Madagascar','MG','MDG','');
INSERT INTO osc_countries VALUES (128,'Malawi','MW','MWI','');
INSERT INTO osc_countries VALUES (129,'Malaysia','MY','MYS','');
INSERT INTO osc_countries VALUES (130,'Maldives','MV','MDV','');
INSERT INTO osc_countries VALUES (131,'Mali','ML','MLI','');
INSERT INTO osc_countries VALUES (132,'Malta','MT','MLT','');
INSERT INTO osc_countries VALUES (133,'Marshall Islands','MH','MHL','');
INSERT INTO osc_countries VALUES (134,'Martinique','MQ','MTQ','');
INSERT INTO osc_countries VALUES (135,'Mauritania','MR','MRT','');
INSERT INTO osc_countries VALUES (136,'Mauritius','MU','MUS','');
INSERT INTO osc_countries VALUES (137,'Mayotte','YT','MYT','');
INSERT INTO osc_countries VALUES (138,'Mexico','MX','MEX',":name\n:street_address\n:postcode :city, :state_code\n:country");
INSERT INTO osc_countries VALUES (139,'Micronesia, Federated States of','FM','FSM','');
INSERT INTO osc_countries VALUES (140,'Moldova, Republic of','MD','MDA','');
INSERT INTO osc_countries VALUES (141,'Monaco','MC','MCO','');
INSERT INTO osc_countries VALUES (142,'Mongolia','MN','MNG','');
INSERT INTO osc_countries VALUES (143,'Montserrat','MS','MSR','');
INSERT INTO osc_countries VALUES (144,'Morocco','MA','MAR','');
INSERT INTO osc_countries VALUES (145,'Mozambique','MZ','MOZ','');
INSERT INTO osc_countries VALUES (146,'Myanmar','MM','MMR','');
INSERT INTO osc_countries VALUES (147,'Namibia','NA','NAM','');
INSERT INTO osc_countries VALUES (148,'Nauru','NR','NRU','');
INSERT INTO osc_countries VALUES (149,'Nepal','NP','NPL','');
INSERT INTO osc_countries VALUES (150,'Netherlands','NL','NLD',":name\n:street_address\n:postcode :city\n:country");
INSERT INTO osc_countries VALUES (151,'Netherlands Antilles','AN','ANT',":name\n:street_address\n:postcode :city\n:country");
INSERT INTO osc_countries VALUES (152,'New Caledonia','NC','NCL','');
INSERT INTO osc_countries VALUES (153,'New Zealand','NZ','NZL',":name\n:street_address\n:suburb\n:city :postcode\n:country");
INSERT INTO osc_countries VALUES (154,'Nicaragua','NI','NIC','');
INSERT INTO osc_countries VALUES (155,'Niger','NE','NER','');
INSERT INTO osc_countries VALUES (156,'Nigeria','NG','NGA','');
INSERT INTO osc_countries VALUES (157,'Niue','NU','NIU','');
INSERT INTO osc_countries VALUES (158,'Norfolk Island','NF','NFK','');
INSERT INTO osc_countries VALUES (159,'Northern Mariana Islands','MP','MNP','');
INSERT INTO osc_countries VALUES (160,'Norway','NO','NOR',":name\n:street_address\nNO-:postcode :city\n:country");
INSERT INTO osc_countries VALUES (161,'Oman','OM','OMN','');
INSERT INTO osc_countries VALUES (162,'Pakistan','PK','PAK','');
INSERT INTO osc_countries VALUES (163,'Palau','PW','PLW','');
INSERT INTO osc_countries VALUES (164,'Panama','PA','PAN','');
INSERT INTO osc_countries VALUES (165,'Papua New Guinea','PG','PNG','');
INSERT INTO osc_countries VALUES (166,'Paraguay','PY','PRY','');
INSERT INTO osc_countries VALUES (167,'Peru','PE','PER','');
INSERT INTO osc_countries VALUES (168,'Philippines','PH','PHL','');
INSERT INTO osc_countries VALUES (169,'Pitcairn','PN','PCN','');
INSERT INTO osc_countries VALUES (170,'Poland','PL','POL',":name\n:street_address\n:postcode :city\n:country");
INSERT INTO osc_countries VALUES (171,'Portugal','PT','PRT',":name\n:street_address\n:postcode :city\n:country");
INSERT INTO osc_countries VALUES (172,'Puerto Rico','PR','PRI','');
INSERT INTO osc_countries VALUES (173,'Qatar','QA','QAT','');
INSERT INTO osc_countries VALUES (174,'Reunion','RE','REU','');
INSERT INTO osc_countries VALUES (175,'Romania','RO','ROM','');
INSERT INTO osc_countries VALUES (176,'Russian Federation','RU','RUS',":name\n:street_address\n:postcode :city\n:country");
INSERT INTO osc_countries VALUES (177,'Rwanda','RW','RWA','');
INSERT INTO osc_countries VALUES (178,'Saint Kitts and Nevis','KN','KNA','');
INSERT INTO osc_countries VALUES (179,'Saint Lucia','LC','LCA','');
INSERT INTO osc_countries VALUES (180,'Saint Vincent and the Grenadines','VC','VCT','');
INSERT INTO osc_countries VALUES (181,'Samoa','WS','WSM','');
INSERT INTO osc_countries VALUES (182,'San Marino','SM','SMR','');
INSERT INTO osc_countries VALUES (183,'Sao Tome and Principe','ST','STP','');
INSERT INTO osc_countries VALUES (184,'Saudi Arabia','SA','SAU','');
INSERT INTO osc_countries VALUES (185,'Senegal','SN','SEN','');
INSERT INTO osc_countries VALUES (186,'Seychelles','SC','SYC','');
INSERT INTO osc_countries VALUES (187,'Sierra Leone','SL','SLE','');
INSERT INTO osc_countries VALUES (188,'Singapore','SG','SGP', ":name\n:street_address\n:city :postcode\n:country");
INSERT INTO osc_countries VALUES (189,'Slovakia (Slovak Republic)','SK','SVK','');
INSERT INTO osc_countries VALUES (190,'Slovenia','SI','SVN','');
INSERT INTO osc_countries VALUES (191,'Solomon Islands','SB','SLB','');
INSERT INTO osc_countries VALUES (192,'Somalia','SO','SOM','');
INSERT INTO osc_countries VALUES (193,'South Africa','ZA','ZAF',":name\n:street_address\n:suburb\n:city\n:postcode :country");
INSERT INTO osc_countries VALUES (194,'South Georgia and the South Sandwich Islands','GS','SGS','');
INSERT INTO osc_countries VALUES (195,'Spain','ES','ESP',":name\n:street_address\n:postcode :city\n:country");
INSERT INTO osc_countries VALUES (196,'Sri Lanka','LK','LKA','');
INSERT INTO osc_countries VALUES (197,'St. Helena','SH','SHN','');
INSERT INTO osc_countries VALUES (198,'St. Pierre and Miquelon','PM','SPM','');
INSERT INTO osc_countries VALUES (199,'Sudan','SD','SDN','');
INSERT INTO osc_countries VALUES (200,'Suriname','SR','SUR','');
INSERT INTO osc_countries VALUES (201,'Svalbard and Jan Mayen Islands','SJ','SJM','');
INSERT INTO osc_countries VALUES (202,'Swaziland','SZ','SWZ','');
INSERT INTO osc_countries VALUES (203,'Sweden','SE','SWE',":name\n:street_address\n:postcode :city\n:country");
INSERT INTO osc_countries VALUES (204,'Switzerland','CH','CHE',":name\n:street_address\n:postcode :city\n:country");
INSERT INTO osc_countries VALUES (205,'Syrian Arab Republic','SY','SYR','');
INSERT INTO osc_countries VALUES (206,'Taiwan','TW','TWN',":name\n:street_address\n:city :postcode\n:country");
INSERT INTO osc_countries VALUES (207,'Tajikistan','TJ','TJK','');
INSERT INTO osc_countries VALUES (208,'Tanzania, United Republic of','TZ','TZA','');
INSERT INTO osc_countries VALUES (209,'Thailand','TH','THA','');
INSERT INTO osc_countries VALUES (210,'Togo','TG','TGO','');
INSERT INTO osc_countries VALUES (211,'Tokelau','TK','TKL','');
INSERT INTO osc_countries VALUES (212,'Tonga','TO','TON','');
INSERT INTO osc_countries VALUES (213,'Trinidad and Tobago','TT','TTO','');
INSERT INTO osc_countries VALUES (214,'Tunisia','TN','TUN','');
INSERT INTO osc_countries VALUES (215,'Turkey','TR','TUR','');
INSERT INTO osc_countries VALUES (216,'Turkmenistan','TM','TKM','');
INSERT INTO osc_countries VALUES (217,'Turks and Caicos Islands','TC','TCA','');
INSERT INTO osc_countries VALUES (218,'Tuvalu','TV','TUV','');
INSERT INTO osc_countries VALUES (219,'Uganda','UG','UGA','');
INSERT INTO osc_countries VALUES (220,'Ukraine','UA','UKR','');
INSERT INTO osc_countries VALUES (221,'United Arab Emirates','AE','ARE','');
INSERT INTO osc_countries VALUES (222,'United Kingdom','GB','GBR',":name\n:street_address\n:city\n:postcode\n:country");
INSERT INTO osc_countries VALUES (223,'United States','US','USA',":name\n:street_address\n:city :state_code :postcode\n:country");
INSERT INTO osc_countries VALUES (224,'United States Minor Outlying Islands','UM','UMI','');
INSERT INTO osc_countries VALUES (225,'Uruguay','UY','URY','');
INSERT INTO osc_countries VALUES (226,'Uzbekistan','UZ','UZB','');
INSERT INTO osc_countries VALUES (227,'Vanuatu','VU','VUT','');
INSERT INTO osc_countries VALUES (228,'Vatican City State (Holy See)','VA','VAT','');
INSERT INTO osc_countries VALUES (229,'Venezuela','VE','VEN','');
INSERT INTO osc_countries VALUES (230,'Viet Nam','VN','VNM','');
INSERT INTO osc_countries VALUES (231,'Virgin Islands (British)','VG','VGB','');
INSERT INTO osc_countries VALUES (232,'Virgin Islands (U.S.)','VI','VIR','');
INSERT INTO osc_countries VALUES (233,'Wallis and Futuna Islands','WF','WLF','');
INSERT INTO osc_countries VALUES (234,'Western Sahara','EH','ESH','');
INSERT INTO osc_countries VALUES (235,'Yemen','YE','YEM','');
INSERT INTO osc_countries VALUES (236,'Yugoslavia','YU','YUG','');
INSERT INTO osc_countries VALUES (237,'Zaire','ZR','ZAR','');
INSERT INTO osc_countries VALUES (238,'Zambia','ZM','ZMB','');
INSERT INTO osc_countries VALUES (239,'Zimbabwe','ZW','ZWE','');

# Regular expression patterns from http://www.creditcardcode.net
INSERT INTO osc_credit_cards VALUES (1,'American Express','/^(34|37)\\d{13}$/','0','0');
INSERT INTO osc_credit_cards VALUES (2,'Diners Club','/^(30|36|38)\\d{12}$/','0','0');
INSERT INTO osc_credit_cards VALUES (3,'JCB','/^((2131|1800)\\d{11}|3[0135]\\d{14})$/','0','0');
INSERT INTO osc_credit_cards VALUES (4,'MasterCard','/^5[1-5]\\d{14}$/','1','0');
INSERT INTO osc_credit_cards VALUES (5,'Visa','/^4\\d{12}(\\d{3})?$/','1','0');
INSERT INTO osc_credit_cards VALUES (6,'Discover Card','/^6011\\d{12}$/','0','0');
INSERT INTO osc_credit_cards VALUES (7,'Solo','/^(63|67)\\d{14}(\\d{2,3})?$/','0','0');
INSERT INTO osc_credit_cards VALUES (8,'Switch','/^(49|56|63|67)\\d{14}(\\d{2,3})?$/','0','0');
INSERT INTO osc_credit_cards VALUES (9,'Australian Bankcard','/^5610\\d{12}$/','0','0');
INSERT INTO osc_credit_cards VALUES (10,'enRoute','/^(2014|2149)\\d{11}$/','0','0');
INSERT INTO osc_credit_cards VALUES (11,'Laser','/^6304\\d{12}(\\d{2,3})?$/','0','0');
INSERT INTO osc_credit_cards VALUES (12,'Maestro','/^(50|56|57|58|6)/','0','0');
INSERT INTO osc_credit_cards VALUES (13,'Saferpay Test Card','/^9451123100000004$/','0','0');

INSERT INTO osc_currencies VALUES (1,'US Dollar','USD','$','','2','1.0000', now());
INSERT INTO osc_currencies VALUES (2,'Euro','EUR','€','','2','1.2076', now());
INSERT INTO osc_currencies VALUES (3,'British Pounds','GBP','£','','2','1.7587', now());

INSERT INTO osc_languages VALUES (1,'English','en_US','en_US.UTF-8,en_US,english','utf-8','%m/%d/%Y','%A %d %B, %Y','%H:%M:%S','ltr',1,'.',',',1);

INSERT INTO osc_orders_status VALUES ( '1', '1', 'Pending');
INSERT INTO osc_orders_status VALUES ( '2', '1', 'Processing');
INSERT INTO osc_orders_status VALUES ( '3', '1', 'Delivered');
INSERT INTO osc_orders_status VALUES ( '4', '1', 'Preparing');

INSERT INTO osc_orders_transactions_status VALUES ( '1', '1', 'Authorize');
INSERT INTO osc_orders_transactions_status VALUES ( '2', '1', 'Cancel');
INSERT INTO osc_orders_transactions_status VALUES ( '3', '1', 'Approve');
INSERT INTO osc_orders_transactions_status VALUES ( '4', '1', 'Inquiry');

INSERT INTO osc_products_images_groups values (1, 1, 'Originals', 'originals', 0, 0, 0);
INSERT INTO osc_products_images_groups values (2, 1, 'Thumbnails', 'thumbnails', 100, 80, 0);
INSERT INTO osc_products_images_groups values (3, 1, 'Product Information Page', 'product_info', 188, 150, 0);
INSERT INTO osc_products_images_groups values (4, 1, 'Large', 'large', 375, 300, 0);
INSERT INTO osc_products_images_groups values (5, 1, 'Mini', 'mini', 50, 40, 0);

INSERT INTO osc_tax_class VALUES (1, 'Taxable Goods', 'The following types of products are included non-food, services, etc', now(), now());

# USA/Florida
INSERT INTO osc_tax_rates VALUES (1, 1, 1, 1, 7.0, 'FL TAX 7.0%', now(), now());
INSERT INTO osc_geo_zones (geo_zone_id,geo_zone_name,geo_zone_description,date_added) VALUES (1,"Florida","Florida local sales tax zone",now());
INSERT INTO osc_zones_to_geo_zones (association_id,zone_country_id,zone_id,geo_zone_id,date_added) VALUES (1,223,176,1,now());

# Templates

INSERT INTO osc_templates VALUES (1, 'osCommerce Default Template', 'default', 'osCommerce', 'http://www.oscommerce.com', 'XHTML 1.0 Transitional', 1, 'Screen');

INSERT INTO osc_templates_boxes VALUES (1,'Best Sellers','best_sellers','osCommerce','http://www.oscommerce.com','boxes');
INSERT INTO osc_templates_boxes VALUES (2,'Categories','categories','osCommerce','http://www.oscommerce.com','boxes');
INSERT INTO osc_templates_boxes VALUES (3,'Currencies','currencies','osCommerce','http://www.oscommerce.com','boxes');
INSERT INTO osc_templates_boxes VALUES (4,'Information','information','osCommerce','http://www.oscommerce.com','boxes');
INSERT INTO osc_templates_boxes VALUES (5,'Languages','languages','osCommerce','http://www.oscommerce.com','boxes');
INSERT INTO osc_templates_boxes VALUES (6,'Manufacturer Info','manufacturer_info','osCommerce','http://www.oscommerce.com','boxes');
INSERT INTO osc_templates_boxes VALUES (7,'Manufacturers','manufacturers','osCommerce','http://www.oscommerce.com','boxes');
INSERT INTO osc_templates_boxes VALUES (8,'Order History','order_history','osCommerce','http://www.oscommerce.com','boxes');
INSERT INTO osc_templates_boxes VALUES (9,'Product Notifications','product_notifications','osCommerce','http://www.oscommerce.com','boxes');
INSERT INTO osc_templates_boxes VALUES (10,'Reviews','reviews','osCommerce','http://www.oscommerce.com','boxes');
INSERT INTO osc_templates_boxes VALUES (11,'Search','search','osCommerce','http://www.oscommerce.com','boxes');
INSERT INTO osc_templates_boxes VALUES (12,'Shopping Cart','shopping_cart','osCommerce','http://www.oscommerce.com','boxes');
INSERT INTO osc_templates_boxes VALUES (13,'Specials','specials','osCommerce','http://www.oscommerce.com','boxes');
INSERT INTO osc_templates_boxes VALUES (14,'Tell a Friend','tell_a_friend','osCommerce','http://www.oscommerce.com','boxes');
INSERT INTO osc_templates_boxes VALUES (15,'What\'s New','whats_new','osCommerce','http://www.oscommerce.com','boxes');
INSERT INTO osc_templates_boxes VALUES (16,'New Products','new_products','osCommerce','http://www.oscommerce.com','content');
INSERT INTO osc_templates_boxes VALUES (17,'Upcoming Products','upcoming_products','osCommerce','http://www.oscommerce.com','content');
INSERT INTO osc_templates_boxes VALUES (18,'Recently Visited','recently_visited','osCommerce','http://www.oscommerce.com','content');
INSERT INTO osc_templates_boxes VALUES (19,'Also Purchased Products','also_purchased_products','osCommerce','http://www.oscommerce.com','content');

INSERT INTO osc_templates_boxes_to_pages VALUES (1,2,1,'*','left',100,0);
INSERT INTO osc_templates_boxes_to_pages VALUES (2,7,1,'*','left',200,0);
INSERT INTO osc_templates_boxes_to_pages VALUES (3,15,1,'*','left',300,0);
INSERT INTO osc_templates_boxes_to_pages VALUES (4,11,1,'*','left',400,0);
INSERT INTO osc_templates_boxes_to_pages VALUES (5,4,1,'*','left',500,0);
INSERT INTO osc_templates_boxes_to_pages VALUES (6,12,1,'*','right',100,0);
INSERT INTO osc_templates_boxes_to_pages VALUES (7,6,1,'products/info','right',200,0);
INSERT INTO osc_templates_boxes_to_pages VALUES (8,8,1,'*','right',300,0);
INSERT INTO osc_templates_boxes_to_pages VALUES (9,1,1,'*','right',400,0);
INSERT INTO osc_templates_boxes_to_pages VALUES (10,9,1,'products/info','right',500,0);
INSERT INTO osc_templates_boxes_to_pages VALUES (11,14,1,'products/info','right',600,0);
INSERT INTO osc_templates_boxes_to_pages VALUES (12,13,1,'*','right',700,0);
INSERT INTO osc_templates_boxes_to_pages VALUES (13,10,1,'*','right',800,0);
INSERT INTO osc_templates_boxes_to_pages VALUES (14,5,1,'*','right',900,0);
INSERT INTO osc_templates_boxes_to_pages VALUES (15,3,1,'*','right',1000,0);
INSERT INTO osc_templates_boxes_to_pages VALUES (16,16,1,'index/category_listing','after',400,0);
INSERT INTO osc_templates_boxes_to_pages VALUES (17,16,1,'index/index','after',400,0);
INSERT INTO osc_templates_boxes_to_pages VALUES (18,17,1,'index/index','after',450,0);
INSERT INTO osc_templates_boxes_to_pages VALUES (19,18,1,'*','after',500,0);
INSERT INTO osc_templates_boxes_to_pages VALUES (20,19,1,'products/info','after',100,0);

INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Minimum List Size', 'BOX_BEST_SELLERS_MIN_LIST', '3', 'Minimum amount of products that must be shown in the listing', '6', '0', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Maximum List Size', 'BOX_BEST_SELLERS_MAX_LIST', '10', 'Maximum amount of products to show in the listing', '6', '0', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Cache Contents', 'BOX_BEST_SELLERS_CACHE', '60', 'Number of minutes to keep the contents cached (0 = no cache)', '6', '0', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) values ('Show Product Count', 'BOX_CATEGORIES_SHOW_PRODUCT_COUNT', '1', 'Show the amount of products each category has', '6', '0', 'osc_cfg_use_get_boolean_value', 'osc_cfg_set_boolean_value(array(1, -1))', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Manufacturers List Size', 'BOX_MANUFACTURERS_LIST_SIZE', '1', 'The size of the manufacturers pull down menu listing.', '6', '0', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Maximum List Size', 'BOX_ORDER_HISTORY_MAX_LIST', '5', 'Maximum amount of products to show in the listing', '6', '0', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Random Review Selection', 'BOX_REVIEWS_RANDOM_SELECT', '10', 'Select a random review from this amount of the newest reviews available', '6', '0', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Cache Contents', 'BOX_REVIEWS_CACHE', '1', 'Number of minutes to keep the contents cached (0 = no cache)', '6', '0', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Random Product Specials Selection', 'BOX_SPECIALS_RANDOM_SELECT', '10', 'Select a random product on special from this amount of the newest products on specials available', '6', '0', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Cache Contents', 'BOX_SPECIALS_CACHE', '1', 'Number of minutes to keep the contents cached (0 = no cache)', '6', '0', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Random New Product Selection', 'BOX_WHATS_NEW_RANDOM_SELECT', '10', 'Select a random new product from this amount of the newest products available', '6', '0', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Cache Contents', 'BOX_WHATS_NEW_CACHE', '1', 'Number of minutes to keep the contents cached (0 = no cache)', '6', '0', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Maximum Entries To Display', 'MODULE_CONTENT_NEW_PRODUCTS_MAX_DISPLAY', '9', 'Maximum number of new products to display', '6', '0', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Cache Contents', 'MODULE_CONTENT_NEW_PRODUCTS_CACHE', '60', 'Number of minutes to keep the contents cached (0 = no cache)', '6', '0', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Minimum Entries To Display', 'MODULE_CONTENT_ALSO_PURCHASED_MIN_DISPLAY', '1', 'Minimum number of also purchased products to display', '6', '0', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Maximum Entries To Display', 'MODULE_CONTENT_ALSO_PURCHASED_MAX_DISPLAY', '6', 'Maximum number of also purchased products to display', '6', '0', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Cache Contents', 'MODULE_CONTENT_ALSO_PURCHASED_PRODUCTS_CACHE', '60', 'Number of minutes to keep the contents cached (0 = no cache)', '6', '0', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Maximum Entries To Display', 'MODULE_CONTENT_UPCOMING_PRODUCTS_MAX_DISPLAY', '10', 'Maximum number of upcoming products to display', '6', '0', now());
INSERT INTO osc_configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Cache Contents', 'MODULE_CONTENT_UPCOMING_PRODUCTS_CACHE', '1440', 'Number of minutes to keep the contents cached (0 = no cache)', '6', '0', now());

# Weight Classes
INSERT INTO osc_weight_classes VALUES (1, 'g', 1, 'Gram(s)');
INSERT INTO osc_weight_classes VALUES (2, 'kg', 1, 'Kilogram(s)');
INSERT INTO osc_weight_classes VALUES (3, 'oz', 1, 'Ounce(s)');
INSERT INTO osc_weight_classes VALUES (4, 'lb', 1, 'Pound(s)');

INSERT INTO osc_weight_classes_rules VALUES (1, 2, '0.0010');
INSERT INTO osc_weight_classes_rules VALUES (1, 3, '0.0352');
INSERT INTO osc_weight_classes_rules VALUES (1, 4, '0.0022');
INSERT INTO osc_weight_classes_rules VALUES (2, 1, '1000.0000');
INSERT INTO osc_weight_classes_rules VALUES (2, 3, '35.2739');
INSERT INTO osc_weight_classes_rules VALUES (2, 4, '2.2046');
INSERT INTO osc_weight_classes_rules VALUES (3, 1, '28.3495');
INSERT INTO osc_weight_classes_rules VALUES (3, 2, '0.0283');
INSERT INTO osc_weight_classes_rules VALUES (3, 4, '0.0625');
INSERT INTO osc_weight_classes_rules VALUES (4, 1, '453.5923');
INSERT INTO osc_weight_classes_rules VALUES (4, 2, '0.4535');
INSERT INTO osc_weight_classes_rules VALUES (4, 3, '16.0000');

# Australia
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (13,'ACT','Australian Capital Territory');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (13,'NSW','New South Wales');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (13,'NT','Northern Territory');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (13,'QLD','Queensland');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (13,'SA','South Australia');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (13,'TAS','Tasmania');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (13,'VIC','Victoria');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (13,'WA','Western Australia');

# Austria
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (14,'BL','Burgenland');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (14,'KN','Kärnten');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (14,'OO','Oberösterreich');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (14,'NO','Niederösterreich');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (14,'SB','Salzburg');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (14,'ST','Steiermark');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (14,'TI','Tirol');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (14,'VB','Voralberg');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (14,'WI','Wien');

# Canada
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (38,'AB','Alberta');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (38,'BC','British Columbia');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (38,'MB','Manitoba');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (38,'NL','Newfoundland and Labrador');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (38,'NB','New Brunswick');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (38,'NT','Northwest Territories');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (38,'NS','Nova Scotia');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (38,'NU','Nunavut');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (38,'ON','Ontario');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (38,'PE','Prince Edward Island');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (38,'QC','Quebec');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (38,'SK','Saskatchewan');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (38,'YT','Yukon Territory');

# Chile
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (43,'AI','Aisén del General Carlos Ibañez');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (43,'AN','Antofagasta');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (43,'AT','Atacama');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (43,'BI','Biobío');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (43,'CO','Coquimbo');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (43,'AR','La Araucanía');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (43,'LI','Libertador Bernardo O\'Higgins');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (43,'LL','Los Lagos');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (43,'MA','Magallanes y de la Antartica');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (43,'ML','Maule');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (43,'RM','Region Metropolitana de Santiago');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (43,'TA','Tarapacá');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (43,'VA','Valparaíso');

# Germany
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (81,'BAW','Baden-Württemberg');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (81,'BAY','Bayern');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (81,'BER','Berlin');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (81,'BRG','Brandenburg');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (81,'BRE','Bremen');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (81,'HAM','Hamburg');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (81,'HES','Hessen');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (81,'MEC','Mecklenburg-Vorpommern');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (81,'NDS','Niedersachsen');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (81,'NRW','Nordrhein-Westfalen');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (81,'RHE','Rheinland-Pfalz');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (81,'SAR','Saarland');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (81,'SAS','Sachsen');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (81,'SAC','Sachsen-Anhalt');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (81,'SCN','Schleswig-Holstein');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (81,'THE','Thüringen');

# Spain
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'A Coruña','A Coruña');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Alava','Alava');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Albacete','Albacete');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Alicante','Alicante');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Almeria','Almeria');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Asturias','Asturias');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Avila','Avila');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Badajoz','Badajoz');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Baleares','Baleares');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Barcelona','Barcelona');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Burgos','Burgos');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Caceres','Caceres');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Cadiz','Cadiz');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Cantabria','Cantabria');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Castellon','Castellon');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Ceuta','Ceuta');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Ciudad Real','Ciudad Real');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Cordoba','Cordoba');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Cuenca','Cuenca');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Girona','Girona');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Granada','Granada');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Guadalajara','Guadalajara');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Guipuzcoa','Guipuzcoa');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Huelva','Huelva');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Huesca','Huesca');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Jaen','Jaen');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'La Rioja','La Rioja');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Las Palmas','Las Palmas');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Leon','Leon');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Lleida','Lleida');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Lugo','Lugo');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Madrid','Madrid');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Malaga','Malaga');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Melilla','Melilla');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Murcia','Murcia');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Navarra','Navarra');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Ourense','Ourense');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Palencia','Palencia');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Pontevedra','Pontevedra');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Salamanca','Salamanca');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Santa Cruz de Tenerife','Santa Cruz de Tenerife');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Segovia','Segovia');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Sevilla','Sevilla');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Soria','Soria');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Tarragona','Tarragona');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Teruel','Teruel');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Toledo','Toledo');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Valencia','Valencia');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Valladolid','Valladolid');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Vizcaya','Vizcaya');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Zamora','Zamora');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (195,'Zaragoza','Zaragoza');

# Sweden
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (203,'K','Blekinge län');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (203,'W','Dalarnas län');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (203,'X','Gävleborgs län');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (203,'I','Gotlands län');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (203,'N','Hallands län');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (203,'Z','Jämtlands län');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (203,'F','Jönköpings län');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (203,'H','Kalmar län');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (203,'G','Kronobergs län');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (203,'BD','Norrbottens län');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (203,'T','Örebro län');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (203,'E','Östergötlands län');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (203,'M','Skåne län');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (203,'D','Södermanlands län');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (203,'AB','Stockholms län');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (203,'C','Uppsala län');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (203,'S','Värmlands län');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (203,'AC','Västerbottens län');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (203,'Y','Västernorrlands län');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (203,'U','Västmanlands län');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (203,'O','Västra Götalands län');

# Swizterland
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (204,'AG','Aargau');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (204,'AR','Appenzell Ausserrhoden');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (204,'AI','Appenzell Innerrhoden');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (204,'BL','Basel-Landschaft');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (204,'BS','Basel-Stadt');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (204,'BE','Bern');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (204,'FR','Freiburg');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (204,'GE','Genf');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (204,'GL','Glarus');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (204,'JU','Graubünden');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (204,'JU','Jura');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (204,'LU','Luzern');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (204,'NE','Neuenburg');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (204,'NW','Nidwalden');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (204,'OW','Obwalden');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (204,'SH','Schaffhausen');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (204,'SZ','Schwyz');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (204,'SO','Solothurn');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (204,'SG','St. Gallen');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (204,'TI','Tessin');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (204,'TG','Thurgau');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (204,'UR','Uri');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (204,'VD','Waadt');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (204,'VS','Wallis');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (204,'ZG','Zug');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (204,'ZH','Zürich');

# USA
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'AL','Alabama');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'AK','Alaska');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'AS','American Samoa');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'AZ','Arizona');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'AR','Arkansas');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'AF','Armed Forces Africa');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'AA','Armed Forces Americas');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'AC','Armed Forces Canada');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'AE','Armed Forces Europe');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'AM','Armed Forces Middle East');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'AP','Armed Forces Pacific');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'CA','California');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'CO','Colorado');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'CT','Connecticut');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'DE','Delaware');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'DC','District of Columbia');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'FM','Federated States Of Micronesia');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'FL','Florida');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'GA','Georgia');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'GU','Guam');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'HI','Hawaii');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'ID','Idaho');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'IL','Illinois');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'IN','Indiana');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'IA','Iowa');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'KS','Kansas');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'KY','Kentucky');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'LA','Louisiana');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'ME','Maine');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'MH','Marshall Islands');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'MD','Maryland');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'MA','Massachusetts');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'MI','Michigan');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'MN','Minnesota');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'MS','Mississippi');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'MO','Missouri');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'MT','Montana');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'NE','Nebraska');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'NV','Nevada');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'NH','New Hampshire');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'NJ','New Jersey');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'NM','New Mexico');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'NY','New York');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'NC','North Carolina');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'ND','North Dakota');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'MP','Northern Mariana Islands');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'OH','Ohio');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'OK','Oklahoma');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'OR','Oregon');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'PW','Palau');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'PA','Pennsylvania');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'PR','Puerto Rico');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'RI','Rhode Island');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'SC','South Carolina');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'SD','South Dakota');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'TN','Tennessee');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'TX','Texas');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'UT','Utah');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'VT','Vermont');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'VI','Virgin Islands');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'VA','Virginia');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'WA','Washington');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'WV','West Virginia');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'WI','Wisconsin');
INSERT INTO osc_zones (zone_country_id, zone_code, zone_name) VALUES (223,'WY','Wyoming');
