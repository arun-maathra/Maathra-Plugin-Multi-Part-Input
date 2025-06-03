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
--   Date and Time:   12:24 Tuesday June 3, 2025
--   Exported By:     EMBDEV01
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 24881778473020754
--   Manifest End
--   Version:         24.2.5
--   Instance ID:     7954017359603514
--

begin
  -- replace components
  wwv_flow_imp.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/item_type/maathra_segmented_input65630
begin
wwv_flow_imp_shared.create_plugin(
 p_id=>wwv_flow_imp.id(24881778473020754)
,p_plugin_type=>'ITEM TYPE'
,p_name=>'MAATHRA_SEGMENTED_INPUT65630'
,p_display_name=>'MAATHRA - Varying Multi-Part Input'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'procedure render_input (',
'    p_item        in apex_plugin.t_item,',
'    p_plugin      in apex_plugin.t_plugin,',
'    p_param       in apex_plugin.t_item_render_param,',
'    p_result      in out nocopy apex_plugin.t_item_render_result )',
'is',
'    l_num_parts         number := nvl(p_item.attributes.get_number(''attribute_01''), 4);',
'    l_variable_length_yn varchar2(1) := nvl(p_item.attributes.get_varchar2(''attribute_04''), ''N'');',
'    l_lengths_str       varchar2(4000) := p_item.attributes.get_varchar2(''attribute_02'');',
'    l_part_lengths      apex_t_varchar2 := apex_string.split(l_lengths_str, '','');',
'    l_item_id           varchar2(255) := apex_escape.html_attribute(p_item.name);',
'    l_item_name         varchar2(255) := apex_escape.html_attribute(p_item.name);',
'    l_value_parts       apex_t_varchar2;',
'    l_value             varchar2(32767) := p_param.value;',
'    l_html              clob := '''';',
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
'            begin',
'                l_html := l_html || ''<input type="text"'';',
'                l_html := l_html || '' id="'' || l_item_id || ''_PART_'' || i || ''"'';',
'                l_html := l_html || '' class="multi-part-input-part apex-item-text"'';',
'                l_html := l_html || '' maxlength="'' || l_maxlength || ''"'';',
'                l_html := l_html || '' style="width: '' || (l_maxlength * 20) || ''px; text-align: center; min-width:50px"'';',
'                if p_param.is_readonly then',
'                    l_html := l_html || '' readonly="readonly"'';',
'                end if;',
'                if l_value_parts.exists(i) then',
'                    l_html := l_html || '' value="'' || apex_escape.html_attribute(l_value_parts(i)) || ''"'';',
'                end if;',
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
'            begin',
'                l_html := l_html || ''<input type="text"'';',
'                l_html := l_html || '' id="'' || l_item_id || ''_PART_'' || i || ''"'';',
'                l_html := l_html || '' class="multi-part-input-part apex-item-text"'';',
'                l_html := l_html || '' maxlength="'' || l_single_length || ''"'';',
'                l_html := l_html || '' style="width: '' || (l_single_length * 25) || ''px; text-align: center; min-width:50px"'';',
'                if p_param.is_readonly then',
'                    l_html := l_html || '' readonly="readonly"'';',
'                end if;',
'                if l_value_parts.exists(i) then',
'                    l_html := l_html || '' value="'' || apex_escape.html_attribute(l_value_parts(i)) || ''"'';',
'                end if;',
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
,p_version_scn=>39427424720076
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'250102'
,p_about_url=>'https://maathra.com'
,p_files_version=>41
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(24885656271032055)
,p_plugin_id=>wwv_flow_imp.id(24881778473020754)
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
 p_id=>wwv_flow_imp.id(24885945626033691)
,p_plugin_id=>wwv_flow_imp.id(24881778473020754)
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
 p_id=>wwv_flow_imp.id(24908114616192677)
,p_plugin_id=>wwv_flow_imp.id(24881778473020754)
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
end;
/
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '2866756E6374696F6E282429207B0A20206966202877696E646F772E6170657820262620617065782E6A517565727929207B0A20202020617065782E706C7567696E73203D20617065782E706C7567696E73207C7C207B7D3B0A20202020617065782E70';
wwv_flow_imp.g_varchar2_table(2) := '6C7567696E732E6D74635365676D656E746564496E707574203D207B0A202020202020696E69743A2066756E6374696F6E287054686973496429207B0A2020202020202020766172206974656D4E616D65203D20705468697349643B0A20202020202020';
wwv_flow_imp.g_varchar2_table(3) := '2076617220636F6E7461696E6572203D20646F63756D656E742E676574456C656D656E7442794964286974656D4E616D65202B20275F434F4E5441494E455227293B0A20202020202020206966202821636F6E7461696E6572292072657475726E3B0A20';
wwv_flow_imp.g_varchar2_table(4) := '20202020202020766172207061727473203D20636F6E7461696E65722E717565727953656C6563746F72416C6C28272E6D756C74692D706172742D696E7075742D7061727427293B0A2020202020202020766172206E756D6265724F665061727473203D';
wwv_flow_imp.g_varchar2_table(5) := '2070617274732E6C656E6774683B0A0A202020202020202070617274732E666F72456163682866756E6374696F6E28706172742C20696E64657829207B0A20202020202020202020766172206D61784C656E677468203D207061727365496E7428706172';
wwv_flow_imp.g_varchar2_table(6) := '742E67657441747472696275746528276D61786C656E67746827292C203130293B0A0A20202020202020202020706172742E6164644576656E744C697374656E65722827696E707574272C2066756E6374696F6E2829207B0A2020202020202020202020';
wwv_flow_imp.g_varchar2_table(7) := '2069662028746869732E76616C75652E6C656E677468203E3D206D61784C656E67746820262620696E646578203C206E756D6265724F665061727473202D203129207B0A202020202020202020202020202070617274735B696E646578202B20315D2E66';
wwv_flow_imp.g_varchar2_table(8) := '6F63757328293B0A2020202020202020202020207D0A20202020202020202020202076617220636F6D62696E656456616C7565203D2041727261792E66726F6D287061727473292E6D61702870203D3E20702E76616C7565292E6A6F696E282727293B0A';
wwv_flow_imp.g_varchar2_table(9) := '202020202020202020202020617065782E6974656D286974656D4E616D65292E73657456616C756528636F6D62696E656456616C7565293B0A202020202020202020207D293B0A0A20202020202020202020706172742E6164644576656E744C69737465';
wwv_flow_imp.g_varchar2_table(10) := '6E65722827626C7572272C2066756E6374696F6E2829207B0A20202020202020202020202076617220636F6D62696E656456616C7565203D2041727261792E66726F6D287061727473292E6D61702870203D3E20702E76616C7565292E6A6F696E282727';
wwv_flow_imp.g_varchar2_table(11) := '293B0A202020202020202020202020617065782E6974656D286974656D4E616D65292E73657456616C756528636F6D62696E656456616C7565293B0A202020202020202020207D293B0A0A20202020202020202020706172742E6164644576656E744C69';
wwv_flow_imp.g_varchar2_table(12) := '7374656E657228276B6579646F776E272C2066756E6374696F6E286576656E7429207B0A202020202020202020202020696620286576656E742E6B6579203D3D3D20274261636B73706163652720262620746869732E76616C75652E6C656E677468203D';
wwv_flow_imp.g_varchar2_table(13) := '3D3D203020262620696E646578203E203029207B0A202020202020202020202020202070617274735B696E646578202D20315D2E666F63757328293B0A2020202020202020202020207D0A202020202020202020207D293B0A20202020202020207D293B';
wwv_flow_imp.g_varchar2_table(14) := '0A0A202020202020202076617220696E697469616C436F6D62696E656456616C7565203D2041727261792E66726F6D287061727473292E6D61702870203D3E20702E76616C7565292E6A6F696E282727293B0A2020202020202020617065782E6974656D';
wwv_flow_imp.g_varchar2_table(15) := '286974656D4E616D65292E73657456616C756528696E697469616C436F6D62696E656456616C7565293B0A2020202020207D0A202020207D3B0A0A202020202F2F20496E697469616C697A65206F6E2070616765206C6F616420666F7220616C6C20696E';
wwv_flow_imp.g_varchar2_table(16) := '7374616E636573206F662074686520706C7567696E0A202020202428646F63756D656E74292E6F6E2827617065787265616479272C2066756E6374696F6E2829207B0A202020202020617065782E6974656D2E656163682866756E6374696F6E2829207B';
wwv_flow_imp.g_varchar2_table(17) := '0A2020202020202020766172206974656D4964203D20746869732E77696467657428292E617474722827696427293B0A2020202020202020696620286974656D4964202626206974656D49642E656E64735769746828275F434F4E5441494E4552272929';
wwv_flow_imp.g_varchar2_table(18) := '207B0A20202020202020202020617065782E706C7567696E732E6D74635365676D656E746564496E7075742E696E6974286974656D49642E736C69636528302C202D313029293B202F2F2052656D6F766520275F434F4E5441494E45522720746F206765';
wwv_flow_imp.g_varchar2_table(19) := '74206974656D2049440A20202020202020207D0A2020202020207D293B0A202020207D293B0A20207D0A7D29286170657820262620617065782E6A5175657279203F20617065782E6A5175657279203A206A5175657279293B';
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(24884146199020778)
,p_plugin_id=>wwv_flow_imp.id(24881778473020754)
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
wwv_flow_imp.g_varchar2_table(2) := '3D7B696E69743A66756E6374696F6E2865297B76617220743D652C6E3D646F63756D656E742E676574456C656D656E744279496428742B225F434F4E5441494E455222293B6966286E297B76617220613D6E2E717565727953656C6563746F72416C6C28';
wwv_flow_imp.g_varchar2_table(3) := '222E6D756C74692D706172742D696E7075742D7061727422292C693D612E6C656E6774683B612E666F7245616368282866756E6374696F6E28652C6E297B76617220753D7061727365496E7428652E67657441747472696275746528226D61786C656E67';
wwv_flow_imp.g_varchar2_table(4) := '746822292C3130293B652E6164644576656E744C697374656E65722822696E707574222C2866756E6374696F6E28297B746869732E76616C75652E6C656E6774683E3D7526266E3C692D312626615B6E2B315D2E666F63757328293B76617220653D4172';
wwv_flow_imp.g_varchar2_table(5) := '7261792E66726F6D2861292E6D61702828653D3E652E76616C756529292E6A6F696E282222293B617065782E6974656D2874292E73657456616C75652865297D29292C652E6164644576656E744C697374656E65722822626C7572222C2866756E637469';
wwv_flow_imp.g_varchar2_table(6) := '6F6E28297B76617220653D41727261792E66726F6D2861292E6D61702828653D3E652E76616C756529292E6A6F696E282222293B617065782E6974656D2874292E73657456616C75652865297D29292C652E6164644576656E744C697374656E65722822';
wwv_flow_imp.g_varchar2_table(7) := '6B6579646F776E222C2866756E6374696F6E2865297B224261636B7370616365223D3D3D652E6B65792626303D3D3D746869732E76616C75652E6C656E67746826266E3E302626615B6E2D315D2E666F63757328297D29297D29293B76617220753D4172';
wwv_flow_imp.g_varchar2_table(8) := '7261792E66726F6D2861292E6D61702828653D3E652E76616C756529292E6A6F696E282222293B617065782E6974656D2874292E73657456616C75652875297D7D7D2C6528646F63756D656E74292E6F6E2822617065787265616479222C2866756E6374';
wwv_flow_imp.g_varchar2_table(9) := '696F6E28297B617065782E6974656D2E65616368282866756E6374696F6E28297B76617220653D746869732E77696467657428292E617474722822696422293B652626652E656E64735769746828225F434F4E5441494E455222292626617065782E706C';
wwv_flow_imp.g_varchar2_table(10) := '7567696E732E6D74635365676D656E746564496E7075742E696E697428652E736C69636528302C2D313029297D29297D2929297D28617065782626617065782E6A51756572793F617065782E6A51756572793A6A5175657279293B';
end;
/
begin
wwv_flow_imp_shared.create_plugin_file(
 p_id=>wwv_flow_imp.id(24887114395038103)
,p_plugin_id=>wwv_flow_imp.id(24881778473020754)
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
