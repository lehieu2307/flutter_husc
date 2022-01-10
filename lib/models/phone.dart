

class Phone {
  String? Name;
  String? Price;
  String? Manufacturer;
  String? Cpu;
  String? Screen;
  String? Ram;
  String? InternalMemory;
  Phone(
      {this.Name,
      this.Price,
      this.Manufacturer,
      this.Cpu,
      this.Screen,
      this.Ram,
      this.InternalMemory});

  Phone.fromJson(Map<String, dynamic> json) {
    Name = json['Name'];
    Price = json['Price'];
    Manufacturer = json['Manufacturer'];
    Cpu = json['Cpu'];
    Screen = json['Screen'];
    Ram = json['Ram'];
    InternalMemory=json['InternalMemory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.Name;
    data['Price'] = this.Price;
    data['Manufacturer'] = this.Manufacturer;
    data['Cpu'] = this.Cpu;
    data['Screen'] = this.Screen;
    data['Ram'] = this.Ram;
    data['InternalMemory'] = this.InternalMemory;
    return data;
  }

  bool isFullInformation() {
    if (Name == null ||
        Price == null ||
        Manufacturer == null ||
        Cpu == null ||
        Screen == null ||
        Ram == null ||
        InternalMemory == null
) {
      return false;
    }
    return 
        Name!.isNotEmpty &&
        Price!.isNotEmpty &&
        Manufacturer!.isNotEmpty &&
        Cpu!.isNotEmpty &&
        Screen!.isNotEmpty &&
        Ram!.isNotEmpty &&
        InternalMemory!.isNotEmpty;
  }
}
