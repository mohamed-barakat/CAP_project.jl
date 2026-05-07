
```jldoctest AutoDocTests
julia> using CAP, CartesianCategories

julia> true
true

julia> distributive = DummyCategory( @rec(
          list_of_operations_to_install =
            ListOfDefiningOperations( "IsBicartesianClosedCategory" ),
          properties = [ "IsBicartesianClosedCategory", "IsSkeletalCategory" ] ) );

julia> InfoOfInstalledOperationsOfCategory( distributive )
21 primitive operations were used to derive 129 operations for this category which algorithmically
* IsBicartesianClosedCategory
and not yet algorithmically
* IsDistributiveCategory
and furthermore mathematically
* IsSkeletalCategory

```

```jldoctest AutoDocTests
julia> using CAP, CartesianCategories

julia> I = InitialCategory( )
InitialCategory( )

julia> IsInitialCategory( I )
true

julia> Display( I )
A CAP category with name InitialCategory( ):

5 primitive operations were used to derive 14 operations for this category which not yet algorithmically
* IsEquippedWithHomomorphismStructure
and furthermore mathematically
* IsInitialCategory

julia> OI = Opposite( I )
Opposite( InitialCategory( ) )

julia> IsInitialCategory( OI )
true

julia> Display( OI )
A CAP category with name Opposite( InitialCategory( ) ):

18 primitive operations were used to derive 18 operations for this category which not yet algorithmically
* IsEquippedWithHomomorphismStructure
and furthermore mathematically
* IsInitialCategory

```
