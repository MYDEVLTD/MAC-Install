cask "mysqlworkbench-8.0.25" do
  version "8.0.25"
  sha256 "8da15d32d0c3cc8d43e49f8d3580ddec0d8dcd718153da7c934acf26f83ea0c5"
  url "https://cdn.mysql.com/Downloads/MySQLGUITools/mysql-workbench-community-#{version}-macos-x86_64.dmg"

  livecheck do
    url "https://dev.mysql.com/downloads/workbench/"
    strategy :page_match
    regex(/MySQL\s*Workbench\s*(\d+(?:\.\d+)*)/i)
  end

  name "MySQL Workbench"
  desc "Visual tool to design, develop and administer MySQL servers"
  homepage "https://www.mysql.com/products/workbench/"

  app "MySQLWorkbench.app"

  zap trash: [
    "~/Library/Application Support/MySQL/Workbench",
    "~/Library/Caches/com.oracle.workbench.MySQLWorkbench",
    "~/Library/Preferences/com.oracle.workbench.MySQLWorkbench.plist",
    "~/Library/Saved Application State/com.oracle.workbench.MySQLWorkbench.savedState",
  ]
end