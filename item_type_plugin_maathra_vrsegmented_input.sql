prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- Oracle APEX export file
--
-- You should run this script using a SQL client connected to the database as
-- the owner (parsing schema) of the application or as a database user with the
-- APEX_ADMINISTRATOR_ROLE role.
--
-- This export file has been automatically generated. Modifying this file is not
-- supported by Oracle and can lead to unexpected application and/or instance
-- behavior now or in the future.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.5'
,p_default_workspace_id=>7954240781599311
,p_default_application_id=>104
,p_default_id_offset=>0
,p_default_owner=>'EMBDEV01'
);
end;
/
 
prompt APPLICATION 104 - ARM
--
-- Application Export:
--   Application:     104
--   Name:            ARM
--   Date and Time:   17:59 Wednesday June 4, 2025
--   Exported By:     EMBDEV01
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 25577430815341405
--   Manifest End
--   Version:         24.2.5
--   Instance ID:     7954017359603514
--

begin
  -- replace components
  wwv_flow_imp.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/item_type/maathra_vrsegmented_input
begin
wwv_flow_imp_shared.create_plugin(
 p_id=>wwv_flow_imp.id(25577430815341405)
,p_plugin_type=>'ITEM TYPE'
,p_name=>'MAATHRA_VRSEGMENTED_INPUT'
,p_display_name=>'MAATHRA - Varying Multi-Part Restricted Input'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'procedure render_input (',
'    p_item        in apex_plugin.t_item,',
'    p_plugin      in apex_plugin.t_plugin,',
'    p_param       in apex_plugin.t_item_render_param,',
'    p_result      in out nocopy apex_plugin.t_item_render_result )',
'is',
'    l_num_parts          number := nvl(p_item.attributes.get_number(''attribute_01''), 4);',
'    l_variable_length_yn varchar2(1) := nvl(p_item.attributes.get_varchar2(''attribute_04''), ''N'');',
'    l_lengths_str        varchar2(4000) := p_item.attributes.get_varchar2(''attribute_02'');',
'    l_part_lengths       apex_t_varchar2 := apex_string.split(l_lengths_str, '','');',
'    l_char_patterns_str  varchar2(4000) := p_item.attributes.get_varchar2(''attribute_05'');',
'    l_char_patterns      apex_t_varchar2 := apex_string.split(l_char_patterns_str, '','');',
'    l_text_case_convert  varchar2(1) := nvl(p_item.attributes.get_varchar2(''attribute_06''), ''N''); -- NEW ATTRIBUTE',
'    l_item_id            varchar2(255) := apex_escape.html_attribute(p_item.name);',
'    l_item_name          varchar2(255) := apex_escape.html_attribute(p_item.name);',
'    l_value_parts        apex_t_varchar2;',
'    l_value              varchar2(32767) := p_param.value;',
'    l_html               clob := '''';',
'begin',
'    apex_javascript.add_library(',
'        p_name      => ''mtcSegmentedInput'',',
'        p_directory => p_plugin.file_prefix,',
'        p_version   => null',
'    );',
'',
'    if l_value is not null then',
'        if l_variable_length_yn = ''Y'' and l_part_lengths.count > 0 then',
'            declare',
'                l_index number := 1;',
'            begin',
'                l_value_parts := apex_t_varchar2();',
'                for i in 1 .. l_part_lengths.count loop',
'                    if l_index <= length(l_value) and l_part_lengths.exists(i) then',
'                        l_value_parts.extend;',
'                        l_value_parts(i) := substr(l_value, l_index, to_number(l_part_lengths(i)));',
'                        l_index := l_index + to_number(l_part_lengths(i));',
'                    end if;',
'                end loop;',
'            end;',
'        elsif l_variable_length_yn = ''N'' and l_num_parts > 0 and l_lengths_str is not null then',
'            declare',
'                l_single_length number := to_number(l_lengths_str);',
'                l_index         number := 1;',
'            begin',
'                l_value_parts := apex_t_varchar2();',
'                for i in 1 .. l_num_parts loop',
'                    if l_index <= length(l_value) then',
'                        l_value_parts.extend;',
'                        l_value_parts(i) := substr(l_value, l_index, l_single_length);',
'                        l_index := l_index + l_single_length;',
'                    end if;',
'                end loop;',
'            end;',
'        end if;',
'    end if;',
'',
'    l_html := ''<div id="'' || l_item_id || ''_CONTAINER">'';',
'    if l_variable_length_yn = ''Y'' and l_part_lengths.count > 0 then',
'        for i in 1 .. l_part_lengths.count loop',
'            declare',
'                l_maxlength number := to_number(l_part_lengths(i));',
'                l_pattern_for_part varchar2(100);',
'            begin',
'                if l_char_patterns.exists(i) then',
'                    l_pattern_for_part := l_char_patterns(i);',
'                end if;',
'',
'                l_html := l_html || ''<input type="text"'';',
'                l_html := l_html || '' id="'' || l_item_id || ''_PART_'' || i || ''"'';',
'                l_html := l_html || '' class="multi-part-input-part apex-item-text"'';',
'                l_html := l_html || '' maxlength="'' || l_maxlength || ''"'';',
'                l_html := l_html || '' style="width: '' || (l_maxlength * 30) || ''px; text-align: center; min-width:50px"'';',
'                if p_param.is_readonly then',
'                    l_html := l_html || '' readonly="readonly"'';',
'                end if;',
'                if l_value_parts.exists(i) then',
'                    l_html := l_html || '' value="'' || apex_escape.html_attribute(l_value_parts(i)) || ''"'';',
'                end if;',
'                if l_pattern_for_part is not null then',
'                    l_html := l_html || '' data-pattern="'' || apex_escape.html_attribute(l_pattern_for_part) || ''"'';',
'                end if;',
'                l_html := l_html || '' data-text-case="'' || apex_escape.html_attribute(l_text_case_convert) || ''"''; -- NEW data attribute',
'                l_html := l_html || '' data-part-index="'' || i || ''"'';',
'                l_html := l_html || '' data-maxlength="'' || l_maxlength || ''"'';',
'                l_html := l_html || ''>'';',
'                if i < l_part_lengths.count then',
'                    l_html := l_html || ''&nbsp;'';',
'                end if;',
'            end;',
'        end loop;',
'    else -- Not variable length',
'        for i in 1 .. l_num_parts loop',
'            declare',
'                l_single_length number := to_number(l_lengths_str);',
'                l_pattern_for_part varchar2(100);',
'            begin',
'                if l_char_patterns.exists(i) then',
'                    l_pattern_for_part := l_char_patterns(i);',
'                elsif l_char_patterns.count = 1 then',
'                    l_pattern_for_part := l_char_patterns(1);',
'                end if;',
'',
'                l_html := l_html || ''<input type="text"'';',
'                l_html := l_html || '' id="'' || l_item_id || ''_PART_'' || i || ''"'';',
'                l_html := l_html || '' class="multi-part-input-part apex-item-text"'';',
'                l_html := l_html || '' maxlength="'' || l_single_length || ''"'';',
'                l_html := l_html || '' style="width: '' || (l_single_length * 30) || ''px; text-align: center; min-width:50px"'';',
'                if p_param.is_readonly then',
'                    l_html := l_html || '' readonly="readonly"'';',
'                end if;',
'                if l_value_parts.exists(i) then',
'                    l_html := l_html || '' value="'' || apex_escape.html_attribute(l_value_parts(i)) || ''"'';',
'                end if;',
'                if l_pattern_for_part is not null then',
'                    l_html := l_html || '' data-pattern="'' || apex_escape.html_attribute(l_pattern_for_part) || ''"'';',
'                end if;',
'                l_html := l_html || '' data-text-case="'' || apex_escape.html_attribute(l_text_case_convert) || ''"''; -- NEW data attribute',
'                l_html := l_html || '' data-part-index="'' || i || ''"'';',
'                l_html := l_html || '' data-maxlength="'' || l_single_length || ''"'';',
'                l_html := l_html || ''>'';',
'                if i < l_num_parts then',
'                    l_html := l_html || ''&nbsp;'';',
'                end if;',
'            end;',
'        end loop;',
'    end if;',
'    l_html := l_html || ''</div>'';',
'    l_html := l_html || ''<input type="hidden" id="'' || l_item_id || ''" name="'' || l_item_name || ''" aria-hidden="true">'';',
'',
'    htp.p(l_html);',
'        apex_javascript.add_onload_code(''apex.plugins.mtcSegmentedInput.init("'' || p_item.name || ''")'');',
'end render_input;'))
,p_api_version=>3
,p_render_function=>'render_input'
,p_standard_attributes=>'VISIBLE:FORM_ELEMENT:READONLY:SOURCE:ELEMENT:ELEMENT_OPTION:PLACEHOLDER'
,p_substitute_attributes=>true
,p_version_scn=>39427532528822
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'250102'
,p_about_url=>'https://maathra.com'
,p_files_version=>55
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(25577718879341425)
,p_plugin_id=>wwv_flow_imp.id(25577430815341405)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_static_id=>'attribute_01'
,p_prompt=>'No of Parts'
,p_attribute_type=>'NUMBER'
,p_is_required=>false
,p_is_translatable=>false
,p_examples=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<h3>Example 1: Fixed Length Parts</h3>',
'<p>',
'  In this example, we want 4 parts, each accepting 2 characters.',
'</p>',
'<ul>',
'  <li><strong>No of Parts :</strong> 4</li>',
'  <li><strong>Part Length(s) :</strong> 2</li>',
'  <li><strong>Variable Character/Part Length? :</strong> No</li>',
'</ul>',
'<p>This will render 4 input fields, each with a maximum length of 2 characters.</p>',
'',
'',
'',
'<h3>Example 2: Variable Length Parts</h3>',
'<p>',
'  Here, we want 3 parts with different lengths: the first part should accept 3 characters, the second 3 characters, and the third 4 characters (like a phone number).',
'</p>',
'<ul>',
'  <li><strong>No of Parts :</strong> (This will be determined by the lengths provided)</li>',
'  <li><strong>Part Length(s) :</strong> 3,3,4</li>',
'  <li><strong>Variable Character/Part Length? :</strong> Yes</li>',
'</ul>',
'<p>This will render 3 input fields with maximum lengths of 3, 3, and 4 characters respectively.</p>',
'',
'',
'',
'<h3>Example 3: Another Fixed Length Example</h3>',
'<p>',
'  Let''s create 6 parts, each allowing 1 character (e.g., for a short code).',
'</p>',
'<ul>',
'  <li><strong>No of Parts :</strong> 6</li>',
'  <li><strong>Part Length(s) :</strong> 1</li>',
'  <li><strong>Variable Character/Part Length? :</strong> No</li>',
'</ul>',
'<p>This will render 6 input fields, each with a maximum length of 1 character.</p>',
'',
'',
'',
'<h3>Example 4: Variable Length for a Serial Number</h3>',
'<p>',
'  Suppose you need a serial number with two parts, the first being 5 characters and the second being 7.',
'</p>',
'<ul>',
'  <li><strong>No of Parts :</strong> (Determined by lengths)</li>',
'  <li><strong>Part Length(s) :</strong> 5,7</li>',
'  <li><strong>Variable Character/Part Length? :</strong> Yes</li>',
'</ul>',
'<p>This will render two input fields, the first allowing 5 characters and the second allowing 7.</p>'))
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'  Specify the total number of input segments you want to create.',
'  This value is used to determine how many input fields will be rendered.',
'  When the "Variable Character/Part?" option is set to "No", this value is combined with the "Part Length(s)" attribute to create equally sized segments.',
'  If "Variable Character/Part?" is "Yes", the number of segments will be determined by the comma-separated values provided in the "Part Length(s)" attribute.',
'</p>'))
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(25578054819341428)
,p_plugin_id=>wwv_flow_imp.id(25577430815341405)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_static_id=>'attribute_02'
,p_prompt=>'Part Length(s)'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(25578497561341429)
,p_plugin_id=>wwv_flow_imp.id(25577430815341405)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>15
,p_static_id=>'attribute_04'
,p_prompt=>'Variable Character/Part'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_is_translatable=>false
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(25669429956417933)
,p_plugin_id=>wwv_flow_imp.id(25577430815341405)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_static_id=>'attribute_05'
,p_prompt=>'Input Type/Part'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'  Specify the allowed character types for each segment of the input field. This helps guide users and ensures data is entered in the correct format.',
'</p>',
'<p>',
'  Enter a <strong>comma-separated string</strong> where each entry corresponds to a part of your input. The number of patterns you provide should match the total number of parts.',
'</p>',
'<p>',
'  Use the following codes for each part:',
'</p>',
'<ul>',
'  <li><code>N</code>: Allows only <strong>numeric</strong> characters (0-9).</li>',
'  <li><code>A</code>: Allows only <strong>alphabetic</strong> characters (a-z, A-Z).</li>',
'  <li><code>AN</code>: Allows <strong>alphanumeric</strong> characters (0-9, a-z, A-Z).</li>',
'  <li><code>AU</code>: Allows only <strong>alphabetic</strong> characters, which are automatically converted to <strong>uppercase</strong>.</li>',
'  <li><code>ANU</code>: Allows <strong>alphanumeric</strong> characters, which are automatically converted to <strong>uppercase</strong>.</li>',
'  <li>Leave blank or use <code>ANY</code>: Allows <strong>any</strong> character.</li>',
'</ul>',
'<h3>Examples:</h3>',
'<ul>',
'  <li><strong>For PAN (5 Alphabets, 4 Numbers, 1 Alphabet):</strong><br>',
'    <code>AU,AU,AU,AU,AU,N,N,N,N,AU</code>',
'  </li>',
'  <li><strong>For GSTIN (2 Numbers, 5 Alphabets, 4 Numbers, 1 Alphabet, 1 Number, 2 Alphabets):</strong><br>',
'    <code>N,N,AU,AU,AU,AU,AU,N,N,N,N,AU,N,AU,AU</code>',
'  </li>',
'  <li><strong>For a Simple Code (Part 1 numeric, Part 2 alphanumeric):</strong><br>',
'    <code>N,AN</code>',
'  </li>',
'</ul>'))
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(25787166311478741)
,p_plugin_id=>wwv_flow_imp.id(25577430815341405)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_static_id=>'attribute_06'
,p_prompt=>'Text Case'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_default_value=>'N'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(25787783806480250)
,p_plugin_attribute_id=>wwv_flow_imp.id(25787166311478741)
,p_display_sequence=>10
,p_display_value=>'No Change'
,p_return_value=>'N'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(25788133547481270)
,p_plugin_attribute_id=>wwv_flow_imp.id(25787166311478741)
,p_display_sequence=>20
,p_display_value=>'Upper Case'
,p_return_value=>'U'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(25788591183481956)
,p_plugin_attribute_id=>wwv_flow_imp.id(25787166311478741)
,p_display_sequence=>30
,p_display_value=>'Lower Case'
,p_return_value=>'L'
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '2866756E6374696F6E282429207B0A20206966202877696E646F772E6170657820262620617065782E6A517565727929207B0A20202020617065782E706C7567696E73203D20617065782E706C7567696E73207C7C207B7D3B0A20202020617065782E70';
wwv_flow_imp.g_varchar2_table(2) := '6C7567696E732E6D74635365676D656E746564496E707574203D207B0A202020202020696E69743A2066756E6374696F6E287054686973496429207B0A2020202020202020766172206974656D4E616D65203D20705468697349643B0A20202020202020';
wwv_flow_imp.g_varchar2_table(3) := '2076617220636F6E7461696E6572203D20646F63756D656E742E676574456C656D656E7442794964286974656D4E616D65202B20275F434F4E5441494E455227293B0A20202020202020206966202821636F6E7461696E6572292072657475726E3B0A20';
wwv_flow_imp.g_varchar2_table(4) := '20202020202020766172207061727473203D20636F6E7461696E65722E717565727953656C6563746F72416C6C28272E6D756C74692D706172742D696E7075742D7061727427293B0A2020202020202020766172206E756D6265724F665061727473203D';
wwv_flow_imp.g_varchar2_table(5) := '2070617274732E6C656E6774683B0A0A20202020202020202F2F2048656C7065722066756E6374696F6E7320666F72206368617261637465722074797065730A202020202020202066756E6374696F6E2069734E756D65726963286368617229207B0A20';
wwv_flow_imp.g_varchar2_table(6) := '202020202020202020202072657475726E202F5E5C64242F2E746573742863686172293B0A20202020202020207D0A0A202020202020202066756E6374696F6E206973416C7068616265746963286368617229207B0A2020202020202020202020207265';
wwv_flow_imp.g_varchar2_table(7) := '7475726E202F5E5B612D7A412D5A205D242F2E746573742863686172293B0A20202020202020207D0A0A202020202020202066756E6374696F6E206973416C7068616E756D65726963286368617229207B0A20202020202020202020202072657475726E';
wwv_flow_imp.g_varchar2_table(8) := '202F5E5B612D7A412D5A302D395D242F2E746573742863686172293B0A20202020202020207D0A0A20202020202020202F2F2046756E6374696F6E20746F2067657420746865207061646465642076616C7565206F6620616C6C2070617274730A202020';
wwv_flow_imp.g_varchar2_table(9) := '202020202066756E6374696F6E20676574436F6D62696E656450616464656456616C75652829207B0A20202020202020202020202072657475726E2041727261792E66726F6D287061727473292E6D61702866756E6374696F6E287029207B0A20202020';
wwv_flow_imp.g_varchar2_table(10) := '202020202020202020202020766172207061727456616C7565203D20702E76616C75653B0A2020202020202020202020202020202076617220706172744D61784C656E677468203D207061727365496E7428702E646174617365742E6D61786C656E6774';
wwv_flow_imp.g_varchar2_table(11) := '682C203130293B0A2020202020202020202020202020202072657475726E207061727456616C75652E706164456E6428706172744D61784C656E6774682C20272027293B0A2020202020202020202020207D292E6A6F696E282727293B0A202020202020';
wwv_flow_imp.g_varchar2_table(12) := '20207D0A0A20202020202020202F2F204E45573A2046756E6374696F6E20746F206170706C79206361736520636F6E76657273696F6E20746F2061207370656369666963207061727420656C656D656E740A202020202020202066756E6374696F6E2061';
wwv_flow_imp.g_varchar2_table(13) := '70706C7943617365436F6E76657273696F6E2870617274456C656D656E7429207B0A20202020202020202020202076617220706172745061747465726E203D2070617274456C656D656E742E646174617365742E7061747465726E3B0A20202020202020';
wwv_flow_imp.g_varchar2_table(14) := '20202020207661722070617274476C6F62616C5465787443617365203D2070617274456C656D656E742E646174617365742E74657874436173653B0A0A2020202020202020202020202F2F20312E2048616E646C65207061747465726E2D737065636966';
wwv_flow_imp.g_varchar2_table(15) := '696320757070657263617365202841552C20414E5529202D20746869732074616B657320707265636564656E63650A20202020202020202020202069662028706172745061747465726E2026262028706172745061747465726E2E746F55707065724361';
wwv_flow_imp.g_varchar2_table(16) := '73652829203D3D3D2027415527207C7C20706172745061747465726E2E746F5570706572436173652829203D3D3D2027414E55272929207B0A202020202020202020202020202070617274456C656D656E742E76616C7565203D2070617274456C656D65';
wwv_flow_imp.g_varchar2_table(17) := '6E742E76616C75652E746F55707065724361736528293B0A2020202020202020202020207D0A2020202020202020202020202F2F20322E204170706C7920676C6F62616C206361736520636F6E76657273696F6E206966207061747465726E206469646E';
wwv_flow_imp.g_varchar2_table(18) := '277420616C726561647920666F7263652075707065726361736520414E4420676C6F62616C2073657474696E67206973206E6F7420274E270A202020202020202020202020656C7365206966202870617274476C6F62616C546578744361736520262620';
wwv_flow_imp.g_varchar2_table(19) := '70617274476C6F62616C546578744361736520213D3D20274E2729207B0A202020202020202020202020202020206966202870617274476C6F62616C5465787443617365203D3D3D2027552729207B0A2020202020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(20) := '70617274456C656D656E742E76616C7565203D2070617274456C656D656E742E76616C75652E746F55707065724361736528293B0A202020202020202020202020202020207D20656C7365206966202870617274476C6F62616C5465787443617365203D';
wwv_flow_imp.g_varchar2_table(21) := '3D3D20274C2729207B0A202020202020202020202020202020202020202070617274456C656D656E742E76616C7565203D2070617274456C656D656E742E76616C75652E746F4C6F7765724361736528293B0A202020202020202020202020202020207D';
wwv_flow_imp.g_varchar2_table(22) := '0A2020202020202020202020207D0A20202020202020207D0A0A202020202020202070617274732E666F72456163682866756E6374696F6E28706172742C20696E64657829207B0A20202020202020202020766172206D61784C656E677468203D207061';
wwv_flow_imp.g_varchar2_table(23) := '727365496E7428706172742E67657441747472696275746528276D61786C656E67746827292C203130293B0A20202020202020202020766172207061747465726E203D20706172742E646174617365742E7061747465726E3B202F2F20416C7265616479';
wwv_flow_imp.g_varchar2_table(24) := '20646566696E656420666F722074686973207061727420696E20746865206C6F6F700A2020202020202020202076617220676C6F62616C5465787443617365203D20706172742E646174617365742E74657874436173653B202F2F20416C726561647920';
wwv_flow_imp.g_varchar2_table(25) := '646566696E656420666F722074686973207061727420696E20746865206C6F6F700A0A202020202020202020202F2F204E45573A204170706C79206361736520636F6E76657273696F6E20696D6D6564696174656C79206F6E20696E697469616C697A61';
wwv_flow_imp.g_varchar2_table(26) := '74696F6E20666F7220736176656420646174610A202020202020202020206170706C7943617365436F6E76657273696F6E2870617274293B0A0A202020202020202020202F2F204576656E74206C697374656E657220666F722073747269637420636861';
wwv_flow_imp.g_varchar2_table(27) := '7261637465722076616C69646174696F6E20286265666F72652074686520636861726163746572206973206164646564290A20202020202020202020706172742E6164644576656E744C697374656E657228276265666F7265696E707574272C2066756E';
wwv_flow_imp.g_varchar2_table(28) := '6374696F6E286576656E7429207B0A202020202020202020202020202069662028216576656E742E6461746129207B0A20202020202020202020202020202020202072657475726E3B0A20202020202020202020202020207D0A0A202020202020202020';
wwv_flow_imp.g_varchar2_table(29) := '202020202076617220696E707574537472696E67203D206576656E742E646174613B0A20202020202020202020202020207661722063757272656E745061727456616C7565203D20746869732E76616C75653B0A0A202020202020202020202020202069';
wwv_flow_imp.g_varchar2_table(30) := '66202863757272656E745061727456616C75652E6C656E677468202B20696E707574537472696E672E6C656E677468203E206D61784C656E67746829207B0A2020202020202020202020202020202020206576656E742E70726576656E7444656661756C';
wwv_flow_imp.g_varchar2_table(31) := '7428293B0A20202020202020202020202020202020202072657475726E3B0A20202020202020202020202020207D0A0A2020202020202020202020202020696620287061747465726E202626207061747465726E2E746F55707065724361736528292021';
wwv_flow_imp.g_varchar2_table(32) := '3D3D2027414E592729207B0A202020202020202020202020202020202020666F7220287661722069203D20303B2069203C20696E707574537472696E672E6C656E6774683B20692B2B29207B0A2020202020202020202020202020202020202020202076';
wwv_flow_imp.g_varchar2_table(33) := '61722063686172203D20696E707574537472696E675B695D3B0A2020202020202020202020202020202020202020202076617220697356616C696443686172203D2066616C73653B0A0A2020202020202020202020202020202020202020202073776974';
wwv_flow_imp.g_varchar2_table(34) := '636820287061747465726E2E746F557070657243617365282929207B0A20202020202020202020202020202020202020202020202020206361736520274E273A20697356616C696443686172203D2069734E756D657269632863686172293B2062726561';
wwv_flow_imp.g_varchar2_table(35) := '6B3B0A202020202020202020202020202020202020202020202020202063617365202741273A206361736520274155273A20697356616C696443686172203D206973416C70686162657469632863686172293B20627265616B3B0A202020202020202020';
wwv_flow_imp.g_varchar2_table(36) := '2020202020202020202020202020202020636173652027414E273A20636173652027414E55273A20697356616C696443686172203D206973416C7068616E756D657269632863686172293B20627265616B3B0A2020202020202020202020202020202020';
wwv_flow_imp.g_varchar2_table(37) := '20202020202020202064656661756C743A20697356616C696443686172203D20747275653B0A202020202020202020202020202020202020202020207D0A0A202020202020202020202020202020202020202020206966202821697356616C6964436861';
wwv_flow_imp.g_varchar2_table(38) := '7229207B0A20202020202020202020202020202020202020202020202020206576656E742E70726576656E7444656661756C7428293B0A202020202020202020202020202020202020202020202020202072657475726E3B0A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(39) := '20202020202020202020207D0A2020202020202020202020202020202020207D0A20202020202020202020202020207D0A202020202020202020207D293B0A0A202020202020202020202F2F204576656E74206C697374656E657220666F722067656E65';
wwv_flow_imp.g_varchar2_table(40) := '72616C20696E7075742068616E646C696E672028666F637573206D6F76656D656E742C20636F6D62696E65642076616C75652C207570706572636173652F6C6F7765726361736520636F6E76657273696F6E290A20202020202020202020706172742E61';
wwv_flow_imp.g_varchar2_table(41) := '64644576656E744C697374656E65722827696E707574272C2066756E6374696F6E2829207B0A2020202020202020202020202F2F2043414C4C204E45572046554E4354494F4E3A204170706C79206361736520636F6E76657273696F6E20647572696E67';
wwv_flow_imp.g_varchar2_table(42) := '207573657220696E7075740A2020202020202020202020206170706C7943617365436F6E76657273696F6E2874686973293B0A0A2020202020202020202020202F2F20466F637573206D6F76656D656E743A204D6F766520746F206E6578742070617274';
wwv_flow_imp.g_varchar2_table(43) := '2069662063757272656E7420706172742069732066696C6C65640A20202020202020202020202069662028746869732E76616C75652E6C656E677468203E3D206D61784C656E67746820262620696E646578203C206E756D6265724F665061727473202D';
wwv_flow_imp.g_varchar2_table(44) := '203129207B0A202020202020202020202020202070617274735B696E646578202B20315D2E666F63757328293B0A2020202020202020202020207D0A0A2020202020202020202020202F2F205570646174652068696464656E206974656D27732076616C';
wwv_flow_imp.g_varchar2_table(45) := '75652077697468207061646465642076616C756573206166746572206561636820696E707574206368616E67650A202020202020202020202020617065782E6974656D286974656D4E616D65292E73657456616C756528676574436F6D62696E65645061';
wwv_flow_imp.g_varchar2_table(46) := '6464656456616C75652829293B0A202020202020202020207D293B0A0A202020202020202020202F2F20456E737572652070616464696E67206973206170706C696564207768656E20666F637573206C6561766573206120706172740A20202020202020';
wwv_flow_imp.g_varchar2_table(47) := '202020706172742E6164644576656E744C697374656E65722827626C7572272C2066756E6374696F6E2829207B0A202020202020202020202020617065782E6974656D286974656D4E616D65292E73657456616C756528676574436F6D62696E65645061';
wwv_flow_imp.g_varchar2_table(48) := '6464656456616C75652829293B0A202020202020202020207D293B0A0A202020202020202020202F2F204576656E74206C697374656E657220666F72206261636B7370616365206E617669676174696F6E0A20202020202020202020706172742E616464';
wwv_flow_imp.g_varchar2_table(49) := '4576656E744C697374656E657228276B6579646F776E272C2066756E6374696F6E286576656E7429207B0A202020202020202020202020696620286576656E742E6B6579203D3D3D20274261636B73706163652720262620746869732E76616C75652E6C';
wwv_flow_imp.g_varchar2_table(50) := '656E677468203D3D3D203020262620696E646578203E203029207B0A202020202020202020202020202070617274735B696E646578202D20315D2E666F63757328293B0A2020202020202020202020207D0A202020202020202020207D293B0A20202020';
wwv_flow_imp.g_varchar2_table(51) := '202020207D293B0A0A20202020202020202F2F2053657420696E697469616C20636F6D62696E65642076616C7565206F6E2070616765206C6F61642077697468207061646465642076616C7565730A2020202020202020617065782E6974656D28697465';
wwv_flow_imp.g_varchar2_table(52) := '6D4E616D65292E73657456616C756528676574436F6D62696E656450616464656456616C75652829293B0A2020202020207D0A202020207D3B0A0A202020202428646F63756D656E74292E6F6E2827617065787265616479272C2066756E6374696F6E28';
wwv_flow_imp.g_varchar2_table(53) := '29207B0A2020202020202F2F2054686520696E697469616C697A6174696F6E20666F72206561636820706C7567696E206974656D2069732068616E646C656420627920617065785F6A6176617363726970742E6164645F6F6E6C6F61645F636F64652066';
wwv_flow_imp.g_varchar2_table(54) := '726F6D20504C2F53514C2E0A202020207D293B0A20207D0A7D29286170657820262620617065782E6A5175657279203F20617065782E6A5175657279203A206A5175657279293B';
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(25578879804341434)
,p_plugin_id=>wwv_flow_imp.id(25577430815341405)
,p_file_name=>'mtcSegmentedInput.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '2166756E6374696F6E2865297B77696E646F772E617065782626617065782E6A5175657279262628617065782E706C7567696E733D617065782E706C7567696E737C7C7B7D2C617065782E706C7567696E732E6D74635365676D656E746564496E707574';
wwv_flow_imp.g_varchar2_table(2) := '3D7B696E69743A66756E6374696F6E2865297B76617220743D652C613D646F63756D656E742E676574456C656D656E744279496428742B225F434F4E5441494E455222293B69662861297B766172206E3D612E717565727953656C6563746F72416C6C28';
wwv_flow_imp.g_varchar2_table(3) := '222E6D756C74692D706172742D696E7075742D7061727422292C723D6E2E6C656E6774683B6E2E666F7245616368282866756E6374696F6E28652C61297B766172206C3D7061727365496E7428652E67657441747472696275746528226D61786C656E67';
wwv_flow_imp.g_varchar2_table(4) := '746822292C3130292C633D652E646174617365742E7061747465726E3B652E646174617365742E74657874436173653B6F2865292C652E6164644576656E744C697374656E657228226265666F7265696E707574222C2866756E6374696F6E2865297B69';
wwv_flow_imp.g_varchar2_table(5) := '6628652E64617461297B76617220743D652E646174613B696628746869732E76616C75652E6C656E6774682B742E6C656E6774683E6C29652E70726576656E7444656661756C7428293B656C73652069662863262622414E5922213D3D632E746F557070';
wwv_flow_imp.g_varchar2_table(6) := '657243617365282929666F722876617220613D303B613C742E6C656E6774683B612B2B297B766172206E3D745B615D2C723D21313B73776974636828632E746F5570706572436173652829297B63617365224E223A723D75286E293B627265616B3B6361';
wwv_flow_imp.g_varchar2_table(7) := '73652241223A63617365224155223A723D69286E293B627265616B3B6361736522414E223A6361736522414E55223A723D73286E293B627265616B3B64656661756C743A723D21307D69662821722972657475726E20766F696420652E70726576656E74';
wwv_flow_imp.g_varchar2_table(8) := '44656661756C7428297D7D7D29292C652E6164644576656E744C697374656E65722822696E707574222C2866756E6374696F6E28297B6F2874686973292C746869732E76616C75652E6C656E6774683E3D6C2626613C722D3126266E5B612B315D2E666F';
wwv_flow_imp.g_varchar2_table(9) := '63757328292C617065782E6974656D2874292E73657456616C756528702829297D29292C652E6164644576656E744C697374656E65722822626C7572222C2866756E6374696F6E28297B617065782E6974656D2874292E73657456616C75652870282929';
wwv_flow_imp.g_varchar2_table(10) := '7D29292C652E6164644576656E744C697374656E657228226B6579646F776E222C2866756E6374696F6E2865297B224261636B7370616365223D3D3D652E6B65792626303D3D3D746869732E76616C75652E6C656E6774682626613E3026266E5B612D31';
wwv_flow_imp.g_varchar2_table(11) := '5D2E666F63757328297D29297D29292C617065782E6974656D2874292E73657456616C756528702829297D66756E6374696F6E20752865297B72657475726E2F5E5C64242F2E746573742865297D66756E6374696F6E20692865297B72657475726E2F5E';
wwv_flow_imp.g_varchar2_table(12) := '5B612D7A412D5A205D242F2E746573742865297D66756E6374696F6E20732865297B72657475726E2F5E5B612D7A412D5A302D395D242F2E746573742865297D66756E6374696F6E207028297B72657475726E2041727261792E66726F6D286E292E6D61';
wwv_flow_imp.g_varchar2_table(13) := '70282866756E6374696F6E2865297B76617220743D652E76616C75652C613D7061727365496E7428652E646174617365742E6D61786C656E6774682C3130293B72657475726E20742E706164456E6428612C222022297D29292E6A6F696E282222297D66';
wwv_flow_imp.g_varchar2_table(14) := '756E6374696F6E206F2865297B76617220743D652E646174617365742E7061747465726E2C613D652E646174617365742E74657874436173653B21747C7C22415522213D3D742E746F5570706572436173652829262622414E5522213D3D742E746F5570';
wwv_flow_imp.g_varchar2_table(15) := '7065724361736528293F612626224E22213D3D612626282255223D3D3D613F652E76616C75653D652E76616C75652E746F55707065724361736528293A224C223D3D3D61262628652E76616C75653D652E76616C75652E746F4C6F776572436173652829';
wwv_flow_imp.g_varchar2_table(16) := '29293A652E76616C75653D652E76616C75652E746F55707065724361736528297D7D7D2C6528646F63756D656E74292E6F6E2822617065787265616479222C2866756E6374696F6E28297B7D2929297D28617065782626617065782E6A51756572793F61';
wwv_flow_imp.g_varchar2_table(17) := '7065782E6A51756572793A6A5175657279293B';
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(25815035701203735)
,p_plugin_id=>wwv_flow_imp.id(25577430815341405)
,p_file_name=>'mtcSegmentedInput.min.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/end_environment
begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false)
);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
