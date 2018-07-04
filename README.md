# Dinas-Swift

###Usage

#####normal
```swift
view.din.makeConstraints { (make) in
	make.left.top.equalToSuperview()
	make.width.equalTo(100)
	make.height.equalTo(200)
}
```
#####other
```swift
view.din.makeConstraintsDelay { (make) in
	make.left.top.equalToSuperview()
	make.width.equalTo(100)
	make.height.equalTo(200)
}.bulid() //.bulidAsync()
```
