function Get-XmlDiff($actual, $expected) {
    $doc = New-Object System.Xml.XmlDocument
    $root = $doc.CreateNode("element", "Root", $null)
    
    Get-XmlDiffRecursive $old.Configuration $new.Configuration $root
    
    $doc.AppendChild($root) | Out-Null
    return $doc.Root.InnerXml
}

function Get-XmlDiffRecursive($actual, $expected, $node) {
    if ($actual.OuterXml -ne $expected.OuterXml) {
        if ($expected.NodeType -eq "Element") {
            $element = $doc.CreateElement($expected.Name)
            $node.AppendChild($element) | Out-Null
        }
        else {
            $node.InnerText = $expected.OuterXml
        }
    }
  
    for ($i = 0; $i -lt $expected.ChildNodes.Count; $i = $i + 1) {
        Get-XmlDiffRecursive $actual.ChildNodes[$i] $expected.ChildNodes[$i] $element
    }
}

[xml]$old = Get-Content "configuration.old.xml"
[xml]$new = Get-Content "configuration.new.xml"
cls
Get-XmlDiff $old $new | Out-File new-config.xml -encoding "UTF8"