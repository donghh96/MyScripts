#!/bin/sh


#modify build.properties file
f_build='./LearningTool/Scripts/build.properties'
weblogic_host='infsgvm14.sg.oracle.com'
lt_server='LTServer'
lt_port='7001'

sed -i -e "s/^lt.weblogic.host=/lt.weblogic.host=$weblogic_host/" \
 -e "s/^lt.weblogic.server=/lt.weblogic.server=$lt_server/" \
 -e "s/^lt.weblogic.admin.port=/lt.weblogic.admin.port=$lt_port/" $f_build > build.properties.new


#modify web.xml
f_admin_web='./LearningTool/Configuration/Admin/DeploymentDescriptors/web.xml'
f_lt_web='./LearningTool/Configuration/LearningTool/DeploymentDescriptors/web.xml'
s_timeout='60'

origin_timeout=`grep 'session-timeout' $f_admin_web | awk -F ['<''>'] '{print $3}'`
sed  -i "s/<session-timeout>$origin_timeout<\/session-timeout>/<session-timeout>$s_timeout<\/session-timeout>/" $f_admin_web > adminweb.new

origin_timeout=`grep 'session-timeout' $f_lt_web | awk -F ['<''>'] '{print $3}'`
sed  -i "s/<session-timeout>$origin_timeout<\/session-timeout>/<session-timeout>$s_timeout<\/session-timeout>/" $f_lt_web > ltweb.new

#modify osl_configuration.properties
f_osl_config='./LearningTool/Configuration/LearningTool/DeploymentDescriptors/osl_configuration.properties'

web_contentaccess_homeurl='http://osl302bj06.cn.oracle.com:7779/cs/idcplg?IdcService=GET_DOC_PAGE\&Action=GetTemplatePage\&Page=HOME_PAGE\&Auth=Internet'
web_contentaccess_attached_content_access_baseurl='http://osl302bj06.cn.oracle.com:7779/LTWeb/contentaccessservlet'
content_ucm_ridcuri='idc://osl302bj6vm01.cn.oracle.com:4444'
content_ucm_oslcontent_doctype='Application'
content_ucm_update_url='http://osl302bj06.cn.oracle.com:7779/cs/idcplg?IdcService=GET_UPDATE_FORM'
content_ucm_search_url='http://osl302bj06.cn.oracle.com:7779/cs/idcplg?IdcService=GET_SEARCH_RESULTS'
obiee_host='osl302bj06.cn.oracle.com'
obiee_port='7779'
lt_logout_url='/LTWeb/faces/logout.jspx'
admin_logout_url='/LTAdminWeb/faces/logout.jspx'

sed -i -e  "s#^osl.lt.web.contentAccess.homeURL=#osl.lt.web.contentAccess.homeURL=$web_contentaccess_homeurl#"  \
 -e "s#^osl.lt.web.contentAccess.attachedContentAccessBaseURL=#osl.lt.web.contentAccess.attachedContentAccessBaseURL=$web_contentaccess_attached_content_access_baseurl#" \
  -e "s#^osl.lt.content.ucmIntegration.ridcURI=#osl.lt.content.ucmIntegration.ridcURI=$content_ucm_ridcuri#" \
  -e "s#^osl.lt.content.ucmIntegration.oslContentDoctype=#osl.lt.content.ucmIntegration.oslContentDoctype=$content_ucm_oslcontent_doctype#" \
  -e "s#^osl.lt.content.ucmIntegration.update.URL=#osl.lt.content.ucmIntegration.update.URL=$content_ucm_update_url#" \
  -e "s#^osl.lt.content.ucmIntegration.search.URL=#osl.lt.content.ucmIntegration.search.URL=$content_ucm_search_url#" \
  -e "s#^osl.lt.obiee.integration.host=#osl.lt.obiee.integration.host=$obiee_host#" \
  -e "s#^osl.lt.obiee.integration.port=#osl.lt.obiee.integration.port=$obiee_port#" \
  -e "s#^osl.lt.logout.url=#osl.lt.logout.url=$lt_logout_url#" \
  -e "s#^osl.admin.logout.url=#osl.admin.logout.url=$admin_logout_url#"  $f_osl_config > osl_configue.new
