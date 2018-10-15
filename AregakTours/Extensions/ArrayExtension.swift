extension Array {
	mutating func removeObject<T>(obj: T) where T : Equatable {
		self = self.filter({$0 as? T != obj})
	}
}
