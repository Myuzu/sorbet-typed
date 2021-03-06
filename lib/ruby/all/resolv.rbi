# typed: strict

class Resolv
  sig { params(name: String).returns(String) }
  def self.getaddress(name); end

  sig { params(name: String).returns(T::Array[String]) }
  def self.getaddresses(name); end

  sig { params(name: String, block: T.proc.params(address: String).void).void }
  def self.each_address(name, &block); end

  sig { params(address: String).returns(String) }
  def self.getname(address); end

  sig { params(address: String).returns(T::Array[String]) }
  def self.getnames(address); end

  sig { params(address: String, proc: T.proc.params(name: String).void).void }
  def self.each_name(address, &proc); end

  sig { params(resolvers: [Hosts, DNS]).void }
  def initialize(resolvers=[Hosts.new, DNS.new]); end

  sig { params(name: String).returns(String) }
  def getaddress(name); end

  sig { params(name: String).returns(T::Array[String]) }
  def getaddresses(name); end

  sig { params(name: String, block: T.proc.params(address: String).void).void }
  def each_address(name, &block); end

  sig { params(address: String).returns(String) }
  def getname(address); end

  sig { params(address: String).returns(T::Array[String]) }
  def getnames(address); end

  sig { params(address: String, proc: T.proc.params(name: String).void).void }
  def each_name(address, &proc); end

  class ResolvError < StandardError; end
  class ResolvTimeout < Timeout::Error; end

  class Hosts
    DefaultFileName = T.let(T.unsafe(nil), String)

    sig { params(filename: String).void }
    def initialize(filename = DefaultFileName); end

    sig { params(name: String).returns(String) }
    def getaddress(name); end

    sig { params(name: String).returns(T::Array[String]) }
    def getaddresses(name); end

    sig { params(name: String, block: T.proc.params(address: String).void).void }
    def each_address(name, &block); end

    sig { params(address: String).returns(String) }
    def getname(address); end

    sig { params(address: String).returns(T::Array[String]) }
    def getnames(address); end

    sig { params(address: String, proc: T.proc.params(name: String).void).void }
    def each_name(address, &proc); end
  end

  class DNS
    Port = T.let(T.unsafe(nil), Integer)

    UDPSize = T.let(T.unsafe(nil), Integer)

    sig do
      params(
        config_info: T.any(
          NilClass,
          String,
          { nameserver: T.any(String, T::Array[String]), search: T::Array[String], ndots: Integer },
          { nameserver_port: T::Array[[String, Integer]], search: T::Array[String], ndots: Integer }
        )
      ).returns(Resolv::DNS)
    end
    def self.open(config_info = nil); end

    sig do
      params(
        config_info: T.any(
          NilClass,
          String,
          { nameserver: T.any(String, T::Array[String]), search: T::Array[String], ndots: Integer },
          { nameserver_port: T::Array[[String, Integer]], search: T::Array[String], ndots: Integer }
        )
      ).void
    end
    def initialize(config_info = nil); end

    sig { params(values: T.any(NilClass, Integer, T::Array[Integer])).void }
    def timeouts=(values); end

    sig { void }
    def close; end

    sig { params(name: String).returns(String) }
    def getaddress(name); end

    sig { params(name: String).returns(T::Array[String]) }
    def getaddresses(name); end

    sig { params(name: String, block: T.proc.params(address: String).void).void }
    def each_address(name, &block); end

    sig { params(address: String).returns(String) }
    def getname(address); end

    sig { params(address: String).returns(T::Array[String]) }
    def getnames(address); end

    sig { params(address: String, proc: T.proc.params(name: String).void).void }
    def each_name(address, &proc); end

    sig do
      params(
        name: T.any(String, Resolv::DNS::Name),
        typeclass: T.class_of(Resolv::DNS::Resource)
      ).returns(Resolv::DNS::Resource)
    end
    def getresource(name, typeclass); end

    sig do
      params(
        name: T.any(String, Resolv::DNS::Name),
        typeclass: T.class_of(Resolv::DNS::Resource)
      ).returns(T::Array[Resolv::DNS::Resource])
    end
    def getresources(name, typeclass); end

    sig do
      params(
        name: T.any(String, Resolv::DNS::Name),
        typeclass: T.class_of(Resolv::DNS::Resource),
        proc: T.proc.params(resource: Resolv::DNS::Resource).void
      ).void
    end
    def each_resource(name, typeclass, &proc); end

    class DecodeError < StandardError; end
    class EncodeError < StandardError; end

    class Name
      sig { params(arg: T.any(String, Resolv::DNS::Name)).returns(Resolv::DNS::Name) }
      def self.create(arg); end

      sig { params(labels: T::Array[String], absolute: T.any(FalseClass, TrueClass)).void }
      def initialize(labels, absolute=true); end

      sig { returns(T.any(FalseClass, TrueClass)) }
      def absolute?; end

      sig { params(other: Resolv::DNS::Name).returns(T.any(FalseClass, TrueClass)) }
      def subdomain_of?(other); end
    end

    class Query; end

    class Resource < Query
      sig { returns(T.nilable(Integer)) }
      attr_reader :ttl

      sig { void }
      def initialize
        @ttl = T.let(T.unsafe(nil), T.nilable(Integer))
      end

      class Generic < Resource
        sig { params(data: T.untyped).void }
        def initialize(data)
          @data = T.let(T.unsafe(nil), T.untyped)
        end

        sig { returns(T.untyped) }
        attr_reader :data
      end

      class DomainName < Resource
        sig { params(name: String).void }
        def initialize(name)
          @name = T.let(T.unsafe(nil), String)
        end

        sig { returns(String) }
        attr_reader :name
      end

      class NS < DomainName; end

      class CNAME < DomainName; end

      class SOA < Resource
        sig do
          params(
            mname: String,
            rname: String,
            serial: Integer,
            refresh: Integer,
            retry_: Integer,
            expire: Integer,
            minimum: Integer
          ).void
        end
        def initialize(mname, rname, serial, refresh, retry_, expire, minimum)
          @mname = T.let(T.unsafe(nil), String)
          @rname = T.let(T.unsafe(nil), String)
          @serial = T.let(T.unsafe(nil), Integer)
          @refresh = T.let(T.unsafe(nil), Integer)
          @retry = T.let(T.unsafe(nil), Integer)
          @expire = T.let(T.unsafe(nil), Integer)
          @minimum = T.let(T.unsafe(nil), Integer)
        end

        sig { returns(String) }
        attr_reader :mname

        sig { returns(String) }
        attr_reader :rname

        sig { returns(Integer) }
        attr_reader :serial

        sig { returns(Integer) }
        attr_reader :refresh

        sig { returns(Integer) }
        attr_reader :retry

        sig { returns(Integer) }
        attr_reader :expire

        sig { returns(Integer) }
        attr_reader :minimum
      end

      class PTR < DomainName; end

      class HINFO < Resource
        sig { params(cpu: String, os: String).void }
        def initialize(cpu, os)
          @cpu = T.let(T.unsafe(nil), String)
          @os = T.let(T.unsafe(nil), String)
        end

        sig { returns(String) }
        attr_reader :cpu

        sig { returns(String) }
        attr_reader :os
      end

      class MINFO < Resource
        sig { params(rmailbx: String, emailbx: String).void }
        def initialize(rmailbx, emailbx)
          @rmailbx = T.let(T.unsafe(nil), String)
          @emailbx = T.let(T.unsafe(nil), String)
        end

        sig { returns(String) }
        attr_reader :rmailbx

        sig { returns(String) }
        attr_reader :emailbx
      end

      class MX < Resource
        sig { params(preference: Integer, exchange: String).void }
        def initialize(preference, exchange)
          @preference = T.let(T.unsafe(nil), Integer)
          @exchange = T.let(T.unsafe(nil), String)
        end

        sig { returns(Integer) }
        attr_reader :preference

        sig { returns(String) }
        attr_reader :exchange
      end

      class TXT < Resource
        sig { params(first_string: String, rest_strings: String).void }
        def initialize(first_string, *rest_strings)
          @strings = T.let(T.unsafe(nil), T::Array[String])
        end

        sig { returns(T::Array[String]) }
        attr_reader :strings

        sig { returns(String) }
        def data; end
      end

      class LOC < Resource
        sig do
          params(
            version: String,
            ssize: T.any(String, Resolv::LOC::Size),
            hprecision: T.any(String, Resolv::LOC::Size),
            vprecision: T.any(String, Resolv::LOC::Size),
            latitude: T.any(String, Resolv::LOC::Coord),
            longitude: T.any(String, Resolv::LOC::Coord),
            altitude: T.any(String, Resolv::LOC::Alt)
          ).void
        end
        def initialize(version, ssize, hprecision, vprecision, latitude, longitude, altitude)
          @version = T.let(T.unsafe(nil), String)
          @ssize = T.let(T.unsafe(nil), Resolv::LOC::Size)
          @hprecision = T.let(T.unsafe(nil), Resolv::LOC::Size)
          @vprecision = T.let(T.unsafe(nil), Resolv::LOC::Size)
          @latitude = T.let(T.unsafe(nil), Resolv::LOC::Coord)
          @longitude = T.let(T.unsafe(nil), Resolv::LOC::Coord)
          @altitude = T.let(T.unsafe(nil), Resolv::LOC::Alt)
        end

        sig { returns(String) }
        attr_reader :version

        sig { returns(Resolv::LOC::Size) }
        attr_reader :ssize

        sig { returns(Resolv::LOC::Size) }
        attr_reader :hprecision

        sig { returns(Resolv::LOC::Size) }
        attr_reader :vprecision

        sig { returns(Resolv::LOC::Coord) }
        attr_reader :latitude

        sig { returns(Resolv::LOC::Coord) }
        attr_reader :longitude

        sig { returns(Resolv::LOC::Alt) }
        attr_reader :altitude
      end

      class ANY < Query; end

      module IN
        class A < Resource
          sig { params(address: String).void }
          def initialize(address)
            @address = T.let(T.unsafe(nil), Resolv::IPv4)
          end

          sig { returns(Resolv::IPv4) }
          attr_reader :address
        end

        class WKS < Resource
          sig { params(address: String, protocol: Integer, bitmap: String).void }
          def initialize(address, protocol, bitmap)
            @address = T.let(T.unsafe(nil), Resolv::IPv4)
            @protocol = T.let(T.unsafe(nil), Integer)
            @bitmap = T.let(T.unsafe(nil), String)
          end

          sig { returns(Resolv::IPv4) }
          attr_reader :address

          sig { returns(Integer) }
          attr_reader :protocol

          sig { returns(String) }
          attr_reader :bitmap
        end

        class AAAA < Resource
          sig { params(address: String).void }
          def initialize(address)
            @address = T.let(T.unsafe(nil), Resolv::IPv6)
          end

          sig { returns(Resolv::IPv6) }
          attr_reader :address
        end

        class SRV < Resource
          # Create a SRV resource record.
          #
          # See the documentation for #priority, #weight, #port and #target
          # for +priority+, +weight+, +port and +target+ respectively.

          sig do
            params(
              priority: T.any(Integer, String),
              weight: T.any(Integer, String),
              port: T.any(Integer, String),
              target: T.any(String, Resolv::DNS::Name)
            ).void
          end
          def initialize(priority, weight, port, target)
            @priority = T.let(T.unsafe(nil), Integer)
            @weight = T.let(T.unsafe(nil), Integer)
            @port = T.let(T.unsafe(nil), Integer)
            @target = T.let(T.unsafe(nil), Resolv::DNS::Name)
          end

          sig { returns(Integer) }
          attr_reader :priority

          sig { returns(Integer) }
          attr_reader :weight

          sig { returns(Integer) }
          attr_reader :port

          sig { returns(Resolv::DNS::Name) }
          attr_reader :target
        end
      end
    end
  end

  class IPv4
    Regex256 = T.let(T.unsafe(nil), Regexp)
    Regex = T.let(T.unsafe(nil), Regexp)

    sig { params(arg: T.any(String, Resolv::IPv4)).returns(Resolv::IPv4) }
    def self.create(arg); end

    sig { params(address: String).void }
    def initialize(address)
      @address = T.let(T.unsafe(nil), String)
    end

    sig { returns(String) }
    attr_reader :address

    sig { returns(DNS::Name) }
    def to_name; end
  end

  class IPv6
    Regex_8Hex = T.let(T.unsafe(nil), Regexp)
    Regex_CompressedHex = T.let(T.unsafe(nil), Regexp)
    Regex_6Hex4Dec = T.let(T.unsafe(nil), Regexp)
    Regex_CompressedHex4Dec = T.let(T.unsafe(nil), Regexp)
    Regex = T.let(T.unsafe(nil), Regexp)

    sig { params(arg: T.any(String, Resolv::IPv6)).returns(Resolv::IPv6) }
    def self.create(arg); end

    sig { params(address: String).void }
    def initialize(address)
      @address = T.let(T.unsafe(nil), String)
    end

    sig { returns(String) }
    attr_reader :address

    sig { returns(DNS::Name) }
    def to_name; end
  end

  class MDNS < DNS
    Port = T.let(T.unsafe(nil), Integer)
    AddressV4 = T.let(T.unsafe(nil), String)
    AddressV6 = T.let(T.unsafe(nil), String)
    Addresses = T.let(T.unsafe(nil), [[String, Integer], [String, Integer]])

    sig do
      params(
        config_info: T.any(
          NilClass,
          { nameserver: T.any(String, T::Array[String]), search: T::Array[String], ndots: Integer },
          { nameserver_port: T::Array[[String, Integer]], search: T::Array[String], ndots: Integer }
        )
      ).void
    end
    def initialize(config_info = nil); end
  end

  module LOC
    class Size
      Regex = T.let(T.unsafe(nil), Regexp)

      sig { params(arg: T.any(String, Resolv::LOC::Size)).returns(Resolv::LOC::Size) }
      def self.create(arg); end

      sig { params(scalar: String).void }
      def initialize(scalar)
        @scalar = T.let(T.unsafe(nil), String)
      end

      sig { returns(String) }
      attr_reader :scalar
    end

    class Coord
      Regex = T.let(T.unsafe(nil), Regexp)

      sig { params(arg: T.any(String, Resolv::LOC::Coord)).returns(Resolv::LOC::Coord) }
      def self.create(arg); end

      sig { params(coordinates: String, orientation: T.enum(%w[lat lon])).void }
      def initialize(coordinates, orientation)
        @coordinates = T.let(T.unsafe(nil), String)
        @orientation = T.let(T.unsafe(nil), T.enum(%w[lat lon]))
      end

      sig { returns(String) }
      attr_reader :coordinates

      sig { returns(T.enum(%w[lat lon])) }
      attr_reader :orientation
    end

    class Alt
      Regex = Regex = T.let(T.unsafe(nil), Regexp)

      sig { params(arg: T.any(String, Resolv::LOC::Alt)).returns(Resolv::LOC::Alt) }
      def self.create(arg); end

      sig { params(altitude: String).void }
      def initialize(altitude)
        @altitude = T.let(T.unsafe(nil), String)
      end

      sig { returns(String) }
      attr_reader :altitude
    end
  end

  DefaultResolver = T.let(T.unsafe(nil), Resolv)
  AddressRegex = T.let(T.unsafe(nil), Regexp)
end
