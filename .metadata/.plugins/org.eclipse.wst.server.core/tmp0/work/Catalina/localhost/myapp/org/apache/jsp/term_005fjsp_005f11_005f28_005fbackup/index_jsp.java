/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.96
 * Generated at: 2024-11-28 12:28:02 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.term_005fjsp_005f11_005f28_005fbackup;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import termpackage.DBConnection;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.LinkedHashSet<>(6);
    _jspx_imports_packages.add("java.sql");
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = new java.util.LinkedHashSet<>(2);
    _jspx_imports_classes.add("termpackage.DBConnection");
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    if (!javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      final java.lang.String _jspx_method = request.getMethod();
      if ("OPTIONS".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        return;
      }
      if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSP들은 오직 GET, POST 또는 HEAD 메소드만을 허용합니다. Jasper는 OPTIONS 메소드 또한 허용합니다.");
        return;
      }
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html lang=\"ko\">\r\n");
      out.write("<head>\r\n");
      out.write("    <meta charset=\"UTF-8\">\r\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n");
      out.write("    <title>바꾸다</title>\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"styles.css\">\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"css/main2.css\">\r\n");
      out.write("</head>\r\n");
      out.write("<body style=\"overflow-x: hidden\">\r\n");
      out.write("\r\n");
      out.write("    <!-- 상단 -->\r\n");
      out.write("    <header class=\"header\">\r\n");
      out.write("        <img src=\"images/top_banner.svg\" alt=\"맨위 로고\" class=\"top-bar\">\r\n");
      out.write("        <div class=\"search-bar\">\r\n");
      out.write("            <a href=\"index.jsp\"><img src=\"images/main_logo.svg\" alt=\"로고\" class=\"logo\"></a>\r\n");
      out.write("            <form id=\"searchForm\" action=\"html/search_result.jsp\" method=\"GET\">\r\n");
      out.write("                <div class=\"search-input-container\">\r\n");
      out.write("                    <input type=\"text\" placeholder=\"🔍 물품명, 장터명, 카테고리 태그 등\" class=\"search-input\" id=\"searchInput\" name=\"query\">\r\n");
      out.write("                    <button type=\"submit\" class=\"search-button\" id=\"searchButton\">🔍</button>\r\n");
      out.write("                </div>\r\n");
      out.write("            </form>\r\n");
      out.write("            <div class=\"icons\">\r\n");
      out.write("                <a href=\"html/bookmark.jsp\"><span><img src=\"images/bookmark01.png\" alt=\"북마크\" class=\"icons\"></span></a>\r\n");
      out.write("                <span><img src=\"images/favorite01.png\" alt=\"즐겨찾기\" class=\"icons\"></span>\r\n");
      out.write("                <a href=\"html/my_interface.jsp\"><span><img src=\"images/interpace01.png\" alt=\"내정보\" class=\"icons\"></span></a>\r\n");
      out.write("                ");
 
                // 로그인 상태 확인 후 아이디와 로그아웃 버튼 표시
                String username = (String) session.getAttribute("username");
                if (username != null) { 
                
      out.write("\r\n");
      out.write("                    <span class=\"username-display\">");
      out.print( username );
      out.write("</span>\r\n");
      out.write("                    <a href=\"html/logout.jsp\">\r\n");
      out.write("                        <input type=\"button\" class=\"logout-button\" value=\"로그아웃\">\r\n");
      out.write("                    </a>\r\n");
      out.write("                ");
 
                } else { 
                
      out.write("\r\n");
      out.write("                    <a href=\"html/login.html\">\r\n");
      out.write("                        <input type=\"button\" class=\"login-button\" value=\"로그인\">\r\n");
      out.write("                    </a>\r\n");
      out.write("                ");
 
                } 
                
      out.write("\r\n");
      out.write("            </div>\r\n");
      out.write("        </div>\r\n");
      out.write("        <nav class=\"menu-bar\">\r\n");
      out.write("            <ul>        \r\n");
      out.write("                <li><a href=\"#\"><img src=\"images/category.svg\" alt=\"카테고리\">카테고리</a></li>\r\n");
      out.write("                <li><a href=\"index.html#my-wants\">내가 원해요</a></li>\r\n");
      out.write("                <li><a href=\"index.html#others-wants\">상대방이 원해요</a></li>     \r\n");
      out.write("                <li><a href=\"#\">급상승</a></li>\r\n");
      out.write("                <li><a href=\"#\">쏙</a></li>\r\n");
      out.write("                <li><a href=\"#\">이벤트</a></li>\r\n");
      out.write("                <li><a href=\"html/item.jsp\">상품등록</a></li>\r\n");
      out.write("            </ul>\r\n");
      out.write("        </nav>\r\n");
      out.write("    </header>\r\n");
      out.write("    <main>\r\n");
      out.write("        <div class=\"banner-container\">\r\n");
      out.write("            <div class=\"banner\">\r\n");
      out.write("                <img src=\"images/main_banner1.svg\" alt=\"배너\" class=\"banner-img\">\r\n");
      out.write("            </div>\r\n");
      out.write("        </div>\r\n");
      out.write("\r\n");
      out.write("        <!-- 사이드바 -->\r\n");
      out.write("        <div style=\"flex: 0 0 auto;\">\r\n");
      out.write("            <div class=\"container\" id=\"stickyContainer\">\r\n");
      out.write("                <button type=\"button\" value=\"Top\" onclick=\"clickme()\" style=\"width: 100%; margin-bottom: 10px; padding: 5px; border-radius: 5px; background: white; border: 1px solid #0880F8;\">Top</button>\r\n");
      out.write("                <div class=\"heart-container\">\r\n");
      out.write("                    <div class=\"heart\">❤️</div>\r\n");
      out.write("                    <span class=\"heart-count\">2</span> <!-- 하트 받은 개수 -->\r\n");
      out.write("                </div>\r\n");
      out.write("                <hr class=\"divider\"> <!-- 구분선-->\r\n");
      out.write("                \r\n");
      out.write("                <div class=\"recent-viewed\">최근 본 상품</div>\r\n");
      out.write("                <ul id=\"recentViewedList\"></ul> <!-- 최근 본 상품 목록 -->\r\n");
      out.write("                <ul id=\"delete-btn\"></ul>\r\n");
      out.write("                <!-- 전체 삭제 버튼 -->\r\n");
      out.write("            </div>\r\n");
      out.write("        </div>\r\n");
      out.write("\r\n");
      out.write("        <!-- 최근 상품 -->\r\n");
      out.write("		<div class=\"lastest-item-title\"><h2>최근 올라온 상품</h2></div>\r\n");
      out.write("			<div class=\"lastest-item\">\r\n");
      out.write("			    ");

			        Connection conn = DBConnection.getConnection();
			        if (conn != null) {
			            try (Statement stmt = conn.createStatement();
			            		ResultSet rs = stmt.executeQuery(
			            			    "SELECT product_id, pd_name, pd_price, pd_image, trade_method " +
			            			    "FROM products " +
			            			    "ORDER BY product_id DESC " + // product_id를 기준으로 내림차순 정렬
			            			    "LIMIT 12" // 최대 12개 행만 반환
			            			)) {
			                while (rs.next()) {
			                    String tradeMethod = rs.getString("trade_method"); // trade_method 값을 가져옴
			                    String tradeIcon = "";
			                    if ("exchange".equalsIgnoreCase(tradeMethod)) {
			                        tradeIcon = "images/trade-icon.svg"; // 교환 아이콘 경로
			                    } else if ("sell".equalsIgnoreCase(tradeMethod)) {
			                        tradeIcon = "images/sell-icon.svg"; // 판매 아이콘 경로
			                    }
			    
      out.write("\r\n");
      out.write("			                    <!-- 상품 개별 컨테이너 -->\r\n");
      out.write("			                    <div class=\"product-container\">\r\n");
      out.write("			                        <div class=\"want-item\">\r\n");
      out.write("			                        	<a href=\"html/item_info.jsp?product_id=");
      out.print( rs.getString("product_id") );
      out.write("\">\r\n");
      out.write("			                            <img src=\"");
      out.print( rs.getString("pd_image") );
      out.write("\" alt=\"상품 이미지\" class=\"pd-image\">\r\n");
      out.write("			                            <h5 class=\"pd-name\">");
      out.print( rs.getString("pd_name") );
      out.write("</h5>\r\n");
      out.write("			                            <p class=\"pd-price\">\r\n");
      out.write("			                                ");
      out.print( rs.getInt("pd_price") );
      out.write("\r\n");
      out.write("			                                <img src=\"");
      out.print( tradeIcon );
      out.write("\" alt=\"");
      out.print( tradeMethod );
      out.write("\" class=\"trade-icon\">\r\n");
      out.write("			                            </p>\r\n");
      out.write("			                            </a>\r\n");
      out.write("			                        </div>\r\n");
      out.write("			                    </div>\r\n");
      out.write("			    ");

			                }
			            } catch (SQLException e) {
			                out.println("쿼리 실행 중 오류 발생: " + e.getMessage());
			            } finally {
			                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
			            }
			        } else {
			            out.println("DB 연결 실패");
			        }
			    
      out.write("\r\n");
      out.write("\r\n");
      out.write("		</div>\r\n");
      out.write("	</main>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("    <script src=\"scripts.js\"></script>\r\n");
      out.write("</body>\r\n");
      out.write("</html>\r\n");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
