/*
Make a backup of your database prior to running this script.
Some of the data may already exist in your shop, eg if you have SEO already installed.  Be careful with this script.

Thank you to the osCommece Forum Members who put this script together.

This script will change your site from a (new installation of) 2.3.4(Normal) to a (new installation of) 2.3.4(Responsive).
*/

/* categories */
delete from configuration where configuration_key = 'SHOW_COUNTS';

/* counter */
DROP TABLE IF EXISTS counter;
DROP TABLE IF EXISTS counter_history;

/* store name */
update configuration set configuration_description = 'The name of my store, used online and on printable documents' where configuration_key = 'STORE_NAME';

/* store address */
update configuration set configuration_key = 'STORE_ADDRESS'  where configuration_key = 'STORE_NAME_ADDRESS';
update configuration set configuration_title = 'Store Address' where configuration_key = 'STORE_ADDRESS';
update configuration set configuration_description = 'This is the Address of my store used on printable documents and displayed online' where configuration_key = 'STORE_ADDRESS';

/* store phone */
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Store Phone', 'STORE_PHONE', '555-1234', 'This is the phone number of my store used on printable documents and displayed online', '1', '19', 'tep_cfg_textarea(', now());

/* stock */
update configuration set configuration_value = '<i class="glyphicon glyphicon-asterisk"></i>' where configuration_key = 'STOCK_MARK_PRODUCT_OUT_OF_STOCK';

/* logo */
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Store Logo', 'STORE_LOGO', 'store_logo.png', 'This is the filename of your Store Logo.  This should be updated at admin > configuration > Store Logo', 6, 1000, now());

/* bootstrap config */
SELECT @next_id:=max(configuration_group_id) from configuration_group;
INSERT INTO configuration_group VALUES (@next_id+1, 'Bootstrap Setup', 'Basic Bootstrap Options', @next_id+1, '1');

SELECT @this_id:=max(configuration_group_id) from configuration_group;
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Bootstrap Container', 'BOOTSTRAP_CONTAINER', 'container-fluid', 'What type of container should the page content be shown in? See http://getbootstrap.com/css/#overview-container', @this_id, '1', 'tep_cfg_select_option(array(\'container-fluid\', \'container\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Bootstrap Content', 'BOOTSTRAP_CONTENT', '8', 'What width should the page content default to?  (8 = two thirds width, 6 = half width, 4 = one third width) Note that the Side Column(s) will adjust automatically.', @this_id, '2', 'tep_cfg_select_option(array(\'8\', \'6\', \'4\'), ', now());

/* categories */
ALTER TABLE categories_description ADD COLUMN categories_description TEXT NULL;
ALTER TABLE categories_description ADD COLUMN categories_seo_description TEXT NULL;
ALTER TABLE categories_description ADD COLUMN categories_seo_keywords VARCHAR(128) NULL;
ALTER TABLE categories_description ADD COLUMN categories_seo_title VARCHAR(128) NULL;

/* manufacturers */
ALTER TABLE manufacturers_info ADD COLUMN manufacturers_description TEXT NULL;
ALTER TABLE manufacturers_info ADD COLUMN manufacturers_seo_description TEXT NULL;
ALTER TABLE manufacturers_info ADD COLUMN manufacturers_seo_keywords VARCHAR(128) NULL
ALTER TABLE manufacturers_info ADD COLUMN manufacturers_seo_title VARCHAR(128) NULL;

/* products */
ALTER TABLE products MODIFY products_model VARCHAR(64);
ALTER TABLE products ADD COLUMN products_gtin CHAR(14) NULL;
ALTER TABLE products_description ADD COLUMN products_seo_title VARCHAR(128) NULL;
ALTER TABLE products_description ADD COLUMN products_seo_description text NULL;
ALTER TABLE products_description ADD COLUMN products_seo_keywords VARCHAR(128) NULL;

/* orders products */
ALTER TABLE orders_products MODIFY products_model VARCHAR(64);

/* colorbox hotfix */
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, date_added) values ('Thumbnail Layout', 'MODULE_HEADER_TAGS_PRODUCT_COLORBOX_LAYOUT', '155', 'Layout of Thumbnails', '6', '0', 'ht_product_colorbox_thumbnail_number', now());

/* navbar */
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Installed Modules', 'MODULE_CONTENT_NAVBAR_INSTALLED', 'nb_hamburger_button.php;nb_brand.php;nb_shopping_cart.php', 'List of navbar module filenames separated by a semi-colon. This is automatically updated. No need to edit.', '6', '0', now());

insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Hamburger Button Module', 'MODULE_NAVBAR_HAMBURGER_BUTTON_STATUS', 'True', 'Do you want to add the module to your Navbar?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_NAVBAR_HAMBURGER_BUTTON_CONTENT_PLACEMENT', 'Home', 'This module must be placed in the Home area of the Navbar.', '6', '1', 'tep_cfg_select_option(array(\'Home\'), ', now());
insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_NAVBAR_HAMBURGER_BUTTON_SORT_ORDER', '500', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Brand Module', 'MODULE_NAVBAR_BRAND_STATUS', 'True', 'Do you want to add the module to your Navbar?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_NAVBAR_BRAND_CONTENT_PLACEMENT', 'Home', 'This module must be placed in the Home area of the Navbar.', '6', '1', 'tep_cfg_select_option(array(\'Home\'), ', now());
insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_NAVBAR_BRAND_SORT_ORDER', '505', 'Sort order of display. Lowest is displayed first.', '6', '0', now());
insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Shopping Cart Module', 'MODULE_NAVBAR_SHOPPING_CART_STATUS', 'True', 'Do you want to add the module to your Navbar?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Placement', 'MODULE_NAVBAR_SHOPPING_CART_CONTENT_PLACEMENT', 'Right', 'Should the module be loaded in the Left or Right or the Home area of the Navbar?', '6', '1', 'tep_cfg_select_option(array(\'Left\', \'Right\', \'Home\'), ', now());
insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_NAVBAR_SHOPPING_CART_SORT_ORDER', '550', 'Sort order of display. Lowest is displayed first.', '6', '0', now());

insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Navbar Module', 'MODULE_CONTENT_NAVBAR_STATUS', 'True', 'Should the Navbar be shown? ', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Navbar Style', 'MODULE_CONTENT_NAVBAR_STYLE', 'Inverse', 'What style should the Navbar have?  See http://getbootstrap.com/components/#navbar-inverted', '6', '0', 'tep_cfg_select_option(array(\'Default\', \'Inverse\'), ', now());
insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Navbar Corners', 'MODULE_CONTENT_NAVBAR_CORNERS', 'No', 'Should the Navbar have Corners?', '6', '0', 'tep_cfg_select_option(array(\'Yes\', \'No\'), ', now());
insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Navbar Margin', 'MODULE_CONTENT_NAVBAR_MARGIN', 'Yes', 'Should the Navbar have a bottom Margin?', '6', '0', 'tep_cfg_select_option(array(\'Yes\', \'No\'), ', now());
insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_CONTENT_NAVBAR_SORT_ORDER', '10', 'Sort order of display. Lowest is displayed first.', '6', '0', now());

UPDATE configuration SET configuration_value = 'account/cm_account_set_password;checkout_success/cm_cs_redirect_old_order;checkout_success/cm_cs_thank_you;checkout_success/cm_cs_product_notifications;checkout_success/cm_cs_downloads;header/cm_header_logo;footer/cm_footer_information_links;footer_suffix/cm_footer_extra_copyright;footer_suffix/cm_footer_extra_icons;header/cm_header_search;header/cm_header_messagestack;header/cm_header_breadcrumb;login/cm_login_form;login/cm_create_account_link;navigation/cm_navbar', date_added = now() WHERE configuration_key = 'MODULE_CONTENT_INSTALLED';

/* Logo */
insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Header Logo Module', 'MODULE_CONTENT_HEADER_LOGO_STATUS', 'True', 'Do you want to enable the Logo content module?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Width', 'MODULE_CONTENT_HEADER_LOGO_CONTENT_WIDTH', '6', 'What width container should the content be shown in?', '6', '1', 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), ', now());
insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_CONTENT_HEADER_LOGO_SORT_ORDER', '10', 'Sort order of display. Lowest is displayed first.', '6', '0', now());

/* Search */
insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Search Box Module', 'MODULE_CONTENT_HEADER_SEARCH_STATUS', 'True', 'Do you want to enable the Search Box content module?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Width', 'MODULE_CONTENT_HEADER_SEARCH_CONTENT_WIDTH', '6', 'What width container should the content be shown in?', '6', '1', 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), ', now());
insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_CONTENT_HEADER_SEARCH_SORT_ORDER', '20', 'Sort order of display. Lowest is displayed first.', '6', '0', now());

/* Message Stack */
insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Message Stack Notifications Module', 'MODULE_CONTENT_HEADER_MESSAGESTACK_STATUS', 'True', 'Should the Message Stack Notifications be shown in the header when needed? ', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_CONTENT_HEADER_MESSAGESTACK_SORT_ORDER', '30', 'Sort order of display. Lowest is displayed first.', '6', '0', now());

/* Breadcrumb */
insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Header Breadcrumb Module', 'MODULE_CONTENT_HEADER_BREADCRUMB_STATUS', 'True', 'Do you want to enable the Breadcrumb content module?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Width', 'MODULE_CONTENT_HEADER_BREADCRUMB_CONTENT_WIDTH', '12', 'What width container should the content be shown in?', '6', '1', 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), ', now());
insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_CONTENT_HEADER_BREADCRUMB_SORT_ORDER', '40', 'Sort order of display. Lowest is displayed first.', '6', '0', now());

/* Footer Links */
insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Information Links Footer Module', 'MODULE_CONTENT_FOOTER_INFORMATION_STATUS', 'True', 'Do you want to enable the Information Links content module?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Width', 'MODULE_CONTENT_FOOTER_INFORMATION_CONTENT_WIDTH', '3', 'What width container should the content be shown in? (12 = full width, 6 = half width).', '6', '1', 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), ', now());
insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_CONTENT_FOOTER_INFORMATION_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '0', now());

/* Footer Copyright */
insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Copyright Details Footer Module', 'MODULE_CONTENT_FOOTER_EXTRA_COPYRIGHT_STATUS', 'True', 'Do you want to enable the Copyright content module?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Width', 'MODULE_CONTENT_FOOTER_EXTRA_COPYRIGHT_CONTENT_WIDTH', '6', 'What width container should the content be shown in? (12 = full width, 6 = half width).', '6', '1', 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), ', now());
insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_CONTENT_FOOTER_EXTRA_COPYRIGHT_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '0', now());

/* Footer Icons */
insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable Payment Icons Footer Module', 'MODULE_CONTENT_FOOTER_EXTRA_ICONS_STATUS', 'True', 'Do you want to enable the Payment Icons content module?', '6', '1', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Content Width', 'MODULE_CONTENT_FOOTER_EXTRA_ICONS_CONTENT_WIDTH', '6', 'What width container should the content be shown in? (12 = full width, 6 = half width).', '6', '1', 'tep_cfg_select_option(array(\'12\', \'11\', \'10\', \'9\', \'8\', \'7\', \'6\', \'5\', \'4\', \'3\', \'2\', \'1\'), ', now());
insert into configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_CONTENT_FOOTER_EXTRA_ICONS_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '0', now());

/* SEO */
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('SEO Title Override?', 'MODULE_HEADER_TAGS_CATEGORY_TITLE_SEO_TITLE_OVERRIDE', 'True', 'Do you want to allow category titles to be over-ridden by your SEO Titles (if set)?', '6', '0', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('SEO Breadcrumb Override?', 'MODULE_HEADER_TAGS_CATEGORY_TITLE_SEO_BREADCRUMB_OVERRIDE', 'True', 'Do you want to allow category names in the breadcrumb to be over-ridden by your SEO Titles (if set)?', '6', '0', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('SEO Title Override?', 'MODULE_HEADER_TAGS_MANUFACTURER_TITLE_SEO_TITLE_OVERRIDE', 'True', 'Do you want to allow manufacturer names to be over-ridden by your SEO Titles (if set)?', '6', '0', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('SEO Breadcrumb Override?', 'MODULE_HEADER_TAGS_MANUFACTURER_TITLE_SEO_BREADCRUMB_OVERRIDE', 'True', 'Do you want to allow manufacturer names in the breadcrumb to be over-ridden by your SEO Titles (if set)?', '6', '0', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('SEO Title Override?', 'MODULE_HEADER_TAGS_PRODUCT_TITLE_SEO_TITLE_OVERRIDE', 'True', 'Do you want to allow product titles to be over-ridden by your SEO Titles (if set)?', '6', '0', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('SEO Breadcrumb Override?', 'MODULE_HEADER_TAGS_PRODUCT_TITLE_SEO_BREADCRUMB_OVERRIDE', 'True', 'Do you want to allow product names in the breadcrumb to be over-ridden by your SEO Titles (if set)?', '6', '0', 'tep_cfg_select_option(array(\'True\', \'False\'), ', now());

/* testimonials */
DROP TABLE IF EXISTS testimonials;
CREATE TABLE testimonials (
  testimonials_id int NOT NULL auto_increment,
  customers_name varchar(255) NOT NULL,
  date_added datetime,
  last_modified datetime,
  testimonials_status tinyint(1) NOT NULL default '1',
  PRIMARY KEY (testimonials_id)
);

DROP TABLE IF EXISTS testimonials_description;
CREATE TABLE testimonials_description (
  testimonials_id int NOT NULL,
  languages_id int NOT NULL,
  testimonials_text text NOT NULL,
  PRIMARY KEY (testimonials_id, languages_id)
);


ALTER TABLE `randr_osc_sk_com`.`customers_info` ADD COLUMN `password_reset_key` char(40) AFTER `global_product_notifications`, ADD COLUMN `password_reset_date` datetime AFTER `password_reset_key`;
