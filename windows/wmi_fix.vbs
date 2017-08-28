strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
& "{impersonationLevel=impersonate}!\\" _
& strComputer & "\root\subscription")

Set obj1 = objWMIService.Get("__EventFilter.Name='BVTFilter'")

set obj2set = obj1.Associators_("__FilterToConsumerBinding")

set obj3set = obj1.References_("__FilterToConsumerBinding")



For each obj2 in obj2set
                WScript.echo "Deleting the object"
                WScript.echo obj2.GetObjectText_
                obj2.Delete_
next

For each obj3 in obj3set
                WScript.echo "Deleting the object"
                WScript.echo obj3.GetObjectText_
                obj3.Delete_
next

WScript.echo "Deleting the object"
WScript.echo obj1.GetObjectText_
obj1.Delete_
