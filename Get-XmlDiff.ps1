function Get-XmlDiff($actual, $expected, $node) {
    if ($actual.OuterXml -ne $expected.OuterXml) {
        if($expected.NodeType -eq "Element") {
            $element = $doc.CreateElement($expected.Name)
            $node.AppendChild($element) | Out-Null
        }else{
            $node.InnerText = $expected.OuterXml
        }
    }
  
    for ($i = 0; $i -lt $expected.ChildNodes.Count; $i = $i + 1) {
        Get-XmlDiff $actual.ChildNodes[$i] $expected.ChildNodes[$i] $element
    }
}

$doc = New-Object System.Xml.XmlDocument

[xml]$old = Get-Content "configuration.old.xml"
[xml]$new = Get-Content "configuration.new.xml"

$root = $doc.CreateNode("element", "Root", $null)

Get-XmlDiff $old.Configuration $new.Configuration $root

$doc.AppendChild($root) | Out-Null
$doc.Root.InnerXml | Out-File new-config.xml -encoding "UTF8"